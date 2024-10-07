import { NgModule } from '@angular/core';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HomeComponent } from './home/home.component';
import { ChatComponent } from './chat/chat.component';
import { NbButtonModule, NbCardModule, NbChatModule, NbFormFieldModule, NbInputModule, NbLayoutModule, NbThemeModule } from '@nebular/theme';
import { FormsModule } from '@angular/forms';
import { ChatService } from './service/chat.service';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    ChatComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    NbInputModule,
    NbButtonModule,
    NbCardModule,
    FormsModule,
    NbLayoutModule,
    NbChatModule,
    NbFormFieldModule,
    NbThemeModule.forRoot({ name: 'default' })
  ],
  providers: [ChatService],
  bootstrap: [AppComponent]
})
export class AppModule { }
