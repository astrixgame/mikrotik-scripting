# MikroTik Full config setup

:global read do={:return}

{
    # OpenVPN setup script
    :global funcSetupOpenVPN do={
        :put "==== OpenVPN Config ===="

        :put "Enter your public IP:"
        :local publicIP [$read]
        :put ""

        :put "More settings ..."
        :local moreSettings [$read]

        :put "========================"
        :put ""

        # Test only
        :put "Your public IP is $publicIP"
        :put "Also setting up $moreSettings"
    }

    # Default configuration user selection
    :global funcUserSelConfig do={
        :put "==== Choose configuration ===="
        :put "  1. Full"
        :put "  2. OpenVPN"
        :put "  3. PPoE"
        :put "  4. LTE"
        :put "  5. ..."
        :put "=============================="
        :local selectedConfig [$read]
        :put ""


        # ===============================================
        # Full config setup
        # ===============================================
        :if ([$selectedConfig] = "1") do={
            # Run OpenVPN setup and more ...
            $funcSetupOpenVPN
        }

        # ===============================================
        # OpenVPN setup
        # ===============================================
        :if ([$selectedConfig] = "2") do={
            # Run OpenVPN setup
            $funcSetupOpenVPN
        }

        # ===============================================
        # PPoE setup
        # ===============================================
        :if ([$selectedConfig] = "3") do={
            
        }

        # ===============================================
        # LTE setup
        # ===============================================
        :if ([$selectedConfig] = "4") do={
            
        }
    }

    # Call user configuration selector
    $funcUserSelConfig
}