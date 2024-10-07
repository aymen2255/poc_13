import { Component, OnInit, OnDestroy } from '@angular/core';
import { ActivatedRoute } from "@angular/router";
import { ChatMessage } from '../models/chat-message';
import { ChatService } from '../service/chat.service';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';

@Component({
  selector: 'app-chat',
  templateUrl: './chat.component.html',
  styleUrls: ['./chat.component.scss']
})
export class ChatComponent implements OnInit, OnDestroy {

  // Champ pour le message à envoyer
  inputMessage : string = '';

  // Identifiant de l'utilisateur récupéré depuis les paramètres de route
  userId: string = '';

  // Liste des messages du chat à afficher dans la vue
  chatMessages: ChatMessage[] = [];
  
  // Subject utilisé pour gérer proprement l'unsubscribe aux observables
  private readonly destroy$: Subject<void> = new Subject<void>();

  constructor(private readonly chatService: ChatService,
              private readonly route: ActivatedRoute) { }

  ngOnInit(): void {
    // Récupération de l'ID utilisateur depuis l'URL
    this.userId = this.route.snapshot.params['userId'];

    // Rejoint la salle de chat "SupportClient"
    this.chatService.joinRoom('SupportClient');

    // Initialise l'écoute des nouveaux messages
    this.listenerMessage();
  }

  // Méthode appelée lors de l'envoi d'un message
  sendChatMessage(): void {
    // Vérifie si le message n'est pas vide après trim
    if (this.inputMessage.trim()) {
      // Création d'un objet ChatMessage avec le message et l'ID de l'utilisateur
      const chatMessage: ChatMessage = {
        message: this.inputMessage,
        user: this.userId
      };

      // Envoi du message via le service de chat
      this.chatService.sendChatMessage('SupportClient', chatMessage);

      // Réinitialisation du champ de saisie après l'envoi
      this.inputMessage = '';
    }
  }

  // Écoute les nouveaux messages en provenance du service de chat
  listenerMessage(): void {
    this.chatService.getMessageSubject()
      // Utilise takeUntil pour se désabonner automatiquement lors de la destruction du composant
      .pipe(takeUntil(this.destroy$))
      .subscribe((messages: ChatMessage[]) => {
        // Mappe les messages pour ajouter la propriété messageSide selon l'auteur du message
        this.chatMessages = messages.map((message: ChatMessage) => ({
          ...message,
          messageSide: message.user === this.userId ? 'sender' : 'receiver' // Définit si le message est envoyé ou reçu
        }));
      });
  }

  // Méthode appelée à la destruction du composant
  ngOnDestroy(): void {
    // Émet un signal pour compléter et nettoyer les subscriptions actives
    this.destroy$.next();
    this.destroy$.complete();
  }
}
