//============================================================================
// Name        : Entorno.cpp
// Author      : Profesoras de TALF
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================
#include "Entorno.h"


BITMAP *im_tortuga = NULL; // Declara un BITMAP para la imagen de la tortuga
			BITMAP *buffer = NULL; // Declara un BITMAP para el buffer principal
			BITMAP *buffer2 = NULL; // Declara un BITMAP para el buffer secundario (tortuga)


void linea(int x1,int y1,int x2,int y2, int R, int G, int B){
	line( buffer, x1,y1,x2,y2, makecol( R, G, B));
	blit(buffer, screen, 0,0,0,0,800,600);
}

void pon_tortuga(int x1,int y1,int orientacion){
	

	switch (orientacion){
	case 0: draw_sprite(buffer2, im_tortuga, 0,0);
			break;
	//case 1: rotate_sprite(buffer2,im_tortuga,0,0,itofix(64));
	//		break;
	//case 2: rotate_sprite(buffer2,im_tortuga,0,0,itofix(128));
	//		break;
	//case 3: rotate_sprite(buffer2,im_tortuga,0,0,itofix(192));
	//		break;
	default:rotate_sprite(buffer2,im_tortuga,0,0,itofix(orientacion));break;
	}

		  blit(buffer2, screen, 0,0,x1,y1,64,70);
}

void borra_tortuga(int x1,int y1){
	 	 clear_bitmap(buffer2);
		 blit(buffer2, screen, 0,0,x1,y1,64,70);
		 blit(buffer, screen, 0,0,0,0,800,600);
}

void muestra_mensaje (const TipoMensaje msg) {

	printf("Muestro el mensaje -> %s\n",msg);
	textout_ex( screen, font, "                                        ",  500,550 , makecol( 255,   0, 0), makecol(0, 0, 0));
	textout_ex( screen, font, msg,                                         500,550 , makecol( 255, 255, 0), makecol(0, 0, 0));

}


void inicio(){

		  allegro_init();
		  install_keyboard();
		  set_color_depth(16);
		  set_gfx_mode(GFX_AUTODETECT_WINDOWED, 800, 600, 0, 0);
		  im_tortuga = load_bitmap("tortuga.bmp", NULL); // carga la imagen
		  buffer = create_bitmap(800,600);
		  buffer2 = create_bitmap(800,600);
}

void fin(){
	clear_keybuf();
	destroy_bitmap(im_tortuga);
	destroy_bitmap(buffer);
	destroy_bitmap(buffer2);
}

void borra_pantalla(){
	clear_keybuf();
	clear_bitmap(buffer);
	clear_bitmap(buffer2);
	clear_bitmap(screen);
}
