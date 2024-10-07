import { Injectable, OnDestroy } from '@angular/core';
import { ChatMessage } from "../models/chat-message";
import { BehaviorSubject, Observable } from "rxjs";
import { Client, Frame, Message } from "@stomp/stompjs";
import SockJS from "sockjs-client";

@Injectable({
  providedIn: 'root'
})
export class ChatService implements OnDestroy {

  // Client STOMP pour gérer la communication via WebSocket
  private stompClient: Client | null = null;

  // Subject pour stocker et émettre les messages du chat
  private messageSubject: BehaviorSubject<ChatMessage[]> = new BehaviorSubject<ChatMessage[]>([]);

  // Indicateur de connexion pour vérifier si le client STOMP est connecté
  private connected: boolean = false;

  constructor() {
    // Initialisation de la connexion WebSocket à la création du service
    this.initConnectionSocket();
  }

  // Initialise la connexion WebSocket via SockJS
  private initConnectionSocket(): void {
    const url = '//localhost:8080/chat-websocket'; // URL du serveur WebSocket
    const socket = new SockJS(url); // Création d'un objet SockJS

    // Initialisation du client STOMP avec des options de configuration
    this.stompClient = new Client({
      webSocketFactory: () => socket as WebSocket, // Utilisation de SockJS comme WebSocket
      reconnectDelay: 5000, // Délai de reconnexion en cas de déconnexion
      debug: (str) => console.log(str), // Fonction de debug pour afficher les logs
    });
  }

  // Rejoint une salle de chat spécifiée par l'ID de la salle
  joinRoom(roomId: string): void {
    // Si le client STOMP n'existe pas ou est déjà connecté, on quitte la fonction
    if (!this.stompClient || this.connected) return;

    // Configuration des actions à faire lors de la connexion au serveur
    this.stompClient.onConnect = (frame: Frame) => {
      this.connected = true; // Le client est maintenant connecté

      // Abonnement aux messages de la salle spécifiée
      this.stompClient?.subscribe(`/topic/${roomId}`, (message: Message) => {
        try {
          // Parse le corps du message reçu et l'ajoute à la liste des messages actuels
          const messageContent: ChatMessage = JSON.parse(message.body);
          const currentMessages = this.messageSubject.getValue();
          currentMessages.push(messageContent);
          this.messageSubject.next(currentMessages); // Émet les nouveaux messages
        } catch (error) {
          console.error('Error parsing message: ', error); // Log l'erreur si le parsing échoue
        }
      });
    };

    // Active la connexion WebSocket et démarre l'abonnement
    this.stompClient.activate();
  }

  // Envoie un message à la salle de chat spécifiée
  sendChatMessage(roomId: string, chatMessage: ChatMessage): void {
    // Si le client est connecté, publie le message au serveur
    if (this.stompClient && this.connected) {
      this.stompClient.publish({
        destination: `/app/chat/${roomId}`, // Destination de l'envoi
        body: JSON.stringify(chatMessage),  // Corps du message
      });
    } else {
      // Si le client n'est pas connecté, affiche un message d'erreur
      console.error('Stomp client is not connected.');
    }
  }

  // Retourne un Observable pour s'abonner aux messages du chat
  getMessageSubject(): Observable<ChatMessage[]> {
    return this.messageSubject.asObservable(); // Retourne un flux observable des messages
  }

  // Méthode appelée à la destruction du service pour nettoyer la connexion WebSocket
  ngOnDestroy(): void {
    // Si le client est connecté, on désactive la connexion proprement
    if (this.stompClient && this.connected) {
      this.stompClient.deactivate(); // Déconnexion du client STOMP
      this.connected = false; // Réinitialise l'état de connexion
    }
  }
}
