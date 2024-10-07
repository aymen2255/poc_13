package com.openclassrooms.poc.controller;

import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.openclassrooms.poc.dto.ChatMessageDto;
import com.openclassrooms.poc.service.ChatMessageService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ChatMessageController {

	private final ChatMessageService chatMessageService;

	@MessageMapping("/chat/{roomId}")
	@SendTo("/topic/{roomId}")
	public ChatMessageDto chat(@DestinationVariable String roomId, @Payload ChatMessageDto message) {
		// Validation de l'ID de la room
		if (roomId == null || roomId.trim().isEmpty()) {
			throw new IllegalArgumentException("roomId cannot be null or empty");
		}

		return this.chatMessageService.chat(message);
	}
}