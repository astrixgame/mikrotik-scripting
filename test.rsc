{:global read do={:return};:global funcSetupOpenVPN do={;:put "==== OpenVPN Config ====";:put "Enter your public IP:";:local publicIP [$read];:put "";:put "More settings ...";:local moreSettings [$read];:put "========================";:put "";:put "Your public IP is $publicIP";:put "Also setting up $moreSettings" };:global funcUserSelConfig do={;:put "==== Choose configuration ====";:put "  1. Full";:put "  2. OpenVPN";:put "  3. PPoE";:put "  4. LTE";:put "  5. ...";:put "==============================";:local selectedConfig [$read];:put "";:if ([$selectedConfig] = "1") do={;$funcSetupOpenVPN };:if ([$selectedConfig] = "2") do={;$funcSetupOpenVPN };:if ([$selectedConfig] = "3") do={};:if ([$selectedConfig] = "4") do={} };$funcUserSelConfig }