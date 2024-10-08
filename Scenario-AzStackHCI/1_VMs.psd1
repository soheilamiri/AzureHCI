﻿@{
    'VM0' = @{                                                         # VM0 is the first VM to be created - do not change this name
        vmName                = "00-DC-1"                              # Name of the VM in Hyper-V
        vmPath                = ""
        GoldenImagePath       = "D:\hyper-v\Temp-windows-2022-STD-GUI.vhdx"                 # ??? This is the golden image to use for this VM
        vmMemory              = 2GB                                    # ??? Memory in GB of the VM
        vmGeneration          = 2                                      # Gen 2 VM - you should not use Gen 1 VMs anymore
        vmProcCount           = 4                                      # ??? Number of vCPUs
        vmAutomaticStopAction = "ShutDown"                             # What to do when the host is shut down - saves disk space.
        vmNics                = @{                                     # NICs of the VM  - make sure your hyper-v switch names are correct!
            "aMGMT" = @{"Switch" = "Default Switch"; "VLANID" = "" }         # Don't change: the first NIC in alphabetical order will receive IP address as per 2_UnattendSettings.psd1
            "Ext"   = @{"Switch" = "External"; "VLANID" = "" }        # ??? SetSwitch -> is your external switch name on the physical host
        }
        vmDataDisks           = @()                                     
    }
    'VM1' = @{                                                                  # VM0 is the first VM to be created - do not change this name
        vmName                         = "00-HCI-1"                             # Name of the VM in Hyper-V
        vmPath                         = ""
        GoldenImagePath                = "D:\hyper-v\TEMP-AzureHCI-23H2.vhdx"   # ???This is the golden image to use for this VM
        ExposeVirtualizationExtensions = $true                                  # Expose virtualization extensions to the VM - required for nested virtualization
        vmMemory                       = 6GB                                   # ??? Memory in GB of the VM
        vmGeneration                   = 2                                      # Gen 2 VM - you should not use Gen 1 VMs anymore
        vmProcCount                    = 4                                      # ??? Number of vCPUs
        vmAutomaticStopAction          = "ShutDown"                             # What to do when the host is shut down - saves disk space.
        vmNics                         = @{                                     # NICs of the VM  - make sure your hyper-v switch names are correct!
            "aMGMT" = @{"Switch" = "Default Switch"; "VLANID" = "" ; "MacAddressSpoofing" = $true }   # Don't change:    # the first NIC in alphabetical order will receive IP address as per 2_UnattendSettings.psd1
            "Comp1" = @{"Switch" = "Default Switch"; "VLANID" = "" ; "MacAddressSpoofing" = $true }   # Don't change:    #Get-VMNetworkAdapter -VMName $VM | Set-VMNetworkAdapter -MacAddressSpoofing On
            "Comp2" = @{"Switch" = "Default Switch"; "VLANID" = "" ; "MacAddressSpoofing" = $true }   # Don't change:
            "SMB1"  = @{"Switch" = "Default Switch"; "TrunkedVLANs" = "711" }                                  # Don't change : VLAN settings will be set from inside the VM once HCI deploys.
            "SMB2"  = @{"Switch" = "Default Switch"; "TrunkedVLANs" = "712" }                                  # Don't change : VLAN settings will be set once HCI deploys.
        }
        vmDataDisks                    = @(                                     # Should be symmetric to 2nd node - should be >=4 disks
            @{"DiskName" = "dd-1.vhdx"; "DiskSize" = 50GB }
            @{"DiskName" = "dd-2.vhdx"; "DiskSize" = 50GB }
            @{"DiskName" = "dd-3.vhdx"; "DiskSize" = 50GB }
            @{"DiskName" = "dd-4.vhdx"; "DiskSize" = 50GB }
            @{"DiskName" = "dd-5.vhdx"; "DiskSize" = 50GB }
            @{"DiskName" = "dd-6.vhdx"; "DiskSize" = 50GB }
            @{"DiskName" = "dd-7.vhdx"; "DiskSize" = 50GB }
            @{"DiskName" = "dd-8.vhdx"; "DiskSize" = 50GB }
        )                                     
    }
    'VM2' = @{
        vmName                         = "00-HCI-2"
        vmPath                         = ""                                      # (optional) alternative Path to store the VM files - leave empty to use default (i.e. $vmDirectoryPrefix in CreateHyperVVM.ps1)
        GoldenImagePath                = "D:\hyper-v\TEMP-AzureHCI-23H2.vhdx"              # ???
        ExposeVirtualizationExtensions = $true                              # Expose virtualization extensions to the VM - required for nested virtualization
        vmMemory                       = 6GB                               # ???
        vmGeneration                   = 2
        vmProcCount                    = 4                                  # ???
        vmAutomaticStopAction          = "ShutDown"
        vmNics                         = @{
            "aMGMT" = @{"Switch" = "Default Switch"; "VLANID" = "" ; "MacAddressSpoofing" = $true }          # the first NIC in alphabetical order will receive IP address as per 2_UnattendSettings.psd1
            "Comp1" = @{"Switch" = "Default Switch"; "VLANID" = "" ; "MacAddressSpoofing" = $true }         #Get-VMNetworkAdapter -VMName $VM | Set-VMNetworkAdapter -MacAddressSpoofing On} 
            "Comp2" = @{"Switch" = "Default Switch"; "VLANID" = "" ; "MacAddressSpoofing" = $true } 
            "SMB1"  = @{"Switch" = "Default Switch"; "TrunkedVLANs" = "711" }                                  # Don't change : VLAN settings will be set from inside the VM once HCI deploys.
            "SMB2"  = @{"Switch" = "Default Switch"; "TrunkedVLANs" = "712" }                                  # Don't change : VLAN settings will be set once HCI deploys.
        }
        vmDataDisks                    = @(                                     # (optional) Data disks of the VM
            @{"DiskName" = "dd-1.vhdx"; "DiskSize" = 50GB }
            @{"DiskName" = "dd-2.vhdx"; "DiskSize" = 50GB }
            @{"DiskName" = "dd-3.vhdx"; "DiskSize" = 50GB }
            @{"DiskName" = "dd-4.vhdx"; "DiskSize" = 50GB }
            @{"DiskName" = "dd-5.vhdx"; "DiskSize" = 50GB }
            @{"DiskName" = "dd-6.vhdx"; "DiskSize" = 50GB }
            @{"DiskName" = "dd-7.vhdx"; "DiskSize" = 50GB }
            @{"DiskName" = "dd-8.vhdx"; "DiskSize" = 50GB }
        )  
    }
}