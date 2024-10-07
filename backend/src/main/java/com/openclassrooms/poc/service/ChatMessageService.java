package com.openclassrooms.poc.service;

import com.openclassrooms.poc.dto.ChatMessageDto;

public interface ChatMessageService {
	ChatMessageDto chat(ChatMessageDto message);
}
