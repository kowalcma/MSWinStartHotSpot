# Check if Ethernet is connected
$EthernetConnected = (Get-NetAdapter -Name Ethernet).Status -eq 'Up'

if ($EthernetConnected) {
  # Check if the Mobile Hotspot feature is available
  $MobileHotspotAvailable = Get-NetAdapter -Name Wi-Fi | Get-NetAdapterBinding -ComponentID ms_switch | Where-Object { $_.Enabled -and $_.ComponentID -eq 'ms_switch' }

  if ($MobileHotspotAvailable) {
    # Enable the Mobile Hotspot feature and set it to use the existing WiFi configuration
    netsh wlan set hostednetwork mode=allow ssid=<SSID> key=<password>
    netsh routing ip nat add interface Wi-Fi HNetCfgWlan0
    netsh routing ip nat set interface HNetCfgWlan0 mode=share
    netsh wlan start hostednetwork
  }
}