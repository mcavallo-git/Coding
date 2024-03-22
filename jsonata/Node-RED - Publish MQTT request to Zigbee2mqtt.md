<hr />

### Node-RED - Publish MQTT request to Zigbee2mqtt

***
<!-- ------------------------------------------------------------ -->

- Issue Statement:
  > Zigbee LED controller not sending status in regular intervals. Need to manually press sync button on Zigbee2mqtt on light entity - Entity enters unknown state after ~30m of not updating and no longer is aware of state in HomeAssistant.

- Solution:
  - Create a `Call service` node in Node-RED
  - Server: `Home Assistant`
  - Domain: `mqtt`
  - Service: `publish`
  - Data: `{"topic":"zigbee2mqtt/DEVICE_NICKNAME/get","payload":"{\"brightness\":\"\",\"color\":\"\",\"color_mode\":\"\",\"color_temp\":\"\",\"state\":\"\"}","qos":0,"retain":false}`

- Explanation:
  - The above service calls out to zigbee2mqtt and performs an equivalent action to pressing the sync button on zigbee2mqtt's frontend under the device's `Exposes` tab, for each property mentioned under `payload` in the `Data` part of the request
    - To determine properties for the `payload`, refer to the device's `State` page on zigbee2mqtt's frontend

***
<!-- ------------------------------------------------------------ -->

# Citation(s)

  - [I need to keep refreshing the 'Exposes' in zigbee2mqtt for my lights. : r/homeassistant](https://www.reddit.com/r/homeassistant/comments/15f6dus)

  - [zigbee2mqtt/<DEVICE_ID>/get ? · Issue #518 · Koenkk/zigbee2mqtt · GitHub](https://github.com/Koenkk/zigbee2mqtt/issues/518#issuecomment-436392746)

<hr />