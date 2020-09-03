#include "contiki.h"
#include "net/routing/routing.h"
#include "random.h"
#include "net/netstack.h"
#include "net/ipv6/simple-udp.h"
#include "sys/node-id.h"
#include "sys/log.h"
#include "net/ipv6/uip-ds6-route.h"
#include "net/routing/rpl-lite/rpl.h"
#include "net/link-stats.h"
#include "net/nbr-table.h"
#include "net/ipv6/uiplib.h"
#include <stdio.h>
#include <stdlib.h>
//////////////////////////////////////////
static bool agregationEnabled = false;
//////////////////////////////////////////

#define LOG_MODULE "SENSOR"
#define LOG_LEVEL LOG_LEVEL_INFO
#define UDP_CLIENT_PORT 8765
#define UDP_SERVER_PORT 5678

static struct simple_udp_connection udp_conn;
int dataSum = 0;
int dataCounter = 0;
int avg = 0;


PROCESS(udp_client_process, "UDP Sensor");

AUTOSTART_PROCESSES(&udp_client_process);

PROCESS_THREAD(udp_client_process, ev, data){
  static struct etimer periodic_timer;
  static char str[4];
  uip_ipaddr_t dest_ipaddr;
  PROCESS_BEGIN();
  simple_udp_register(&udp_conn, UDP_CLIENT_PORT, NULL, UDP_SERVER_PORT, NULL);

  while (1)
  {
    if (NETSTACK_ROUTING.node_is_reachable() && NETSTACK_ROUTING.get_root_ipaddr(&dest_ipaddr))
    {
      int temp = rand()%10+20;
      if (agregationEnabled){
        dataSum += temp;
        if (++dataCounter > 4){
          avg = dataSum / 5;
          snprintf(str, sizeof(str), "%d",avg);
          simple_udp_sendto(&udp_conn, str, strlen(str), &dest_ipaddr);
          dataSum = 0;
          dataCounter = 0;
        }
      }else {
        snprintf(str, sizeof(str), "%d",temp);
        simple_udp_sendto(&udp_conn, str, strlen(str), &dest_ipaddr);
      }
    }
    else {
      LOG_INFO("Routing not estabilished yet or server not reachable\n");
    }
    etimer_set(&periodic_timer, 5 * CLOCK_SECOND);
    PROCESS_WAIT_EVENT_UNTIL(etimer_expired(&periodic_timer));

  }
  PROCESS_END();

}
