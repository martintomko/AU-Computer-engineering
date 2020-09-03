#include "contiki.h"
#include <stdio.h>
#include <stdlib.h>
#include "net/routing/routing.h"
#include "net/netstack.h"
#include "net/ipv6/simple-udp.h"
#include "net/ipv6/uiplib.h"
#include "sys/log.h"
#include <string.h>

//////////////////////////////////////////
static bool agregationEnabled = true;
//////////////////////////////////////////
#define LOG_MODULE "AGREGATOR"
#define LOG_LEVEL LOG_LEVEL_INFO
#define UDP_CLIENT_PORT	8765
#define UDP_SERVER_PORT	5678

static struct simple_udp_connection udp_conn;
uip_ipaddr_t sink_ipaddr;
bool sinkAvailable = false;
static char str[10];
const int maxStoredMsgs = 10;
int sum = 0;
int counter = 0;
PROCESS(contiki_ng_br, "Contiki-NG Border Router");
AUTOSTART_PROCESSES(&contiki_ng_br);

static void DoAgregatinAndSend(){
  LOG_INFO("Agregation executed\n");
  if (sinkAvailable){
    snprintf(str, sizeof(str), "%d", sum/maxStoredMsgs);
    simple_udp_sendto(&udp_conn, str, strlen(str), &sink_ipaddr);
  } else {
    LOG_INFO("Sink not available!\n");
  }
  counter = 0;
  sum = 0;
}

static void Send(){
  if (sinkAvailable){
    snprintf(str, sizeof(str), "%d", sum);
    simple_udp_sendto(&udp_conn, str, strlen(str), &sink_ipaddr);
  } else {
    LOG_INFO("Sink not available!\n");
  }

}

static void udp_callback(struct simple_udp_connection *c,
         const uip_ipaddr_t *sender_addr,
         uint16_t sender_port,
         const uip_ipaddr_t *receiver_addr,
         uint16_t receiver_port,
         const uint8_t *data,
         uint16_t datalen){  

  if (strcmp((char *) data, "sink") == 0){
    LOG_INFO("Sink registered: ");
    sinkAvailable = true;
    uip_ipaddr_copy(&sink_ipaddr, sender_addr);
    LOG_INFO_6ADDR(&sink_ipaddr);
    LOG_INFO_("\n");
    simple_udp_sendto(&udp_conn, data, datalen, sender_addr);
    return;
  }

  

  if (agregationEnabled){
    LOG_INFO("Storing received data %d - '%s' \n", counter, (char *) data);
    if (atoi((char *)data) > 27){
      LOG_INFO("EXTREME DETECTED!! Prioritizing message!\n");
      simple_udp_sendto(&udp_conn, data, datalen, &sink_ipaddr);
    }
    sum += atoi((char *)data);
    counter = counter+1;
    if (counter == maxStoredMsgs){
      DoAgregatinAndSend();
    }
  } else {
    LOG_INFO("Piping received data to sink: '%s' \n", (char *) data);
    sum = atoi((char *)data);
    Send();
  }
  


}

/*---------------------------------------------------------------------------*/
PROCESS_THREAD(contiki_ng_br, ev, data)
{
  PROCESS_BEGIN();
  simple_udp_register(&udp_conn, UDP_SERVER_PORT, NULL, UDP_CLIENT_PORT, udp_callback);
  PROCESS_END();
}
