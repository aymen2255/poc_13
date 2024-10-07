package com.openclassrooms.poc.service;

import org.springframework.stereotype.Service;

import com.openclassrooms.poc.dto.ChatMessageDto;

@Service
public class ChatMessageServiceImpl implements ChatMessageService{

    public ChatMessageDto chat(ChatMessageDto message) {
        return new ChatMessageDto(message.getMessage(), message.getUser());
    }
}
