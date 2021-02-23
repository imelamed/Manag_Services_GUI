[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[string]$ServiceName =""

$objForm = New-Object System.Windows.Forms.Form 
$objForm.Text = "Tibco Services Management"
$objForm.Size = New-Object System.Drawing.Size(300,280) 
$objForm.StartPosition = "CenterScreen"
$Icon = New-Object system.drawing.icon ("C:\TibcoServicesManagScript\ConfigureNetworkingTask.ico")
$objForm.Icon = $Icon

$objForm.KeyPreview = $True
$objForm.Add_KeyDown({if ($_.KeyCode -eq "Enter") 
    {$x=$objDropBoxService.SelectedItem;$objForm.Close()}})
$objForm.Add_KeyDown({if ($_.KeyCode -eq "Escape") 
    {$objForm.Close()}})

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Size(150,210)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Cancel"
$CancelButton.Add_Click({$objForm.Close()})
$objForm.Controls.Add($CancelButton)

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Size(75,210)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.Add_Click({

    switch ($objDropBoxService.Text)
    {
    "TIBCO Administrator 5.9 (ESB_DEV)" { $ServiceName = "TIBCOAdmin-ESB_DEV"}
    "TIBCO Administrator 5.9 (ESB_QA)"  { $ServiceName = "TIBCOAdmin-ESB_QA"}
    "TIBCO EMS Server EMS-DEV-APP-7222" { $ServiceName = "tibemsd_EMS-DEV-APP-7222"}
    "TIBCO EMS Server EMS-DEV-INFRA-7333" { $ServiceName = "tibemsd_EMS-DEV-INFRA-7333"}
    "TIBCO EMS Server EMS-QA-8222" { $ServiceName = "tibemsd_EMS-QA-8222"}
    "TIBCO EMS Server EMS-QA-8333" { $ServiceName = "tibemsd_EMS-QA-8333"}
    "TIBCO Hawk Agent" { $ServiceName = "TIBHawkAgent"}
    "TIBCO Hawk Agent (ESB_DEV)" { $ServiceName = "TIBHawkAgent-ESB_DEV-NMMS01"}
    "TIBCO Hawk Agent (ESB_QA)" { $ServiceName = "TIBHawkAgent-ESB_QA-NMMS01"}
    "TIBCO Hawk Event" { $ServiceName = "TIBHawkEvent"}
    "TIBCO Hawk H2 Database" { $ServiceName = "TIBHawkH2Database"}
    "TIBCO Hawk HMA" { $ServiceName = "TIBHawkHMA"}
    }

    if ($objRadioButtStop.Checked -eq $True)
    {
    $objLabelStat.Text = "Stop-Service " + $ServiceName
    Stop-Service $ServiceName
    }

    if ($objRadioButtStart.Checked -eq $True)
    {
    $objLabelStat.Text = "Start-Service " + $ServiceName
    Start-Service $ServiceName
    }

    if ($objRadioButtRestart.Checked -eq $True)
    {
    $objLabelStat.Text = "Restart-Service " + $ServiceName
    Restart-Service $ServiceName
    }

    if ($objRadioButtStat.Checked -eq $True)
    {
    $ServiceStat = Get-Service $ServiceName
    $objLabelStat.Text = "Service: " + $ServiceName + "`nStatus: " + $ServiceStat.Status
    }

    if ($?)
    {
    $objLabelStat.Text += "`nSuccessfully Done."
    }
    else
    {
    $objLabelStat.Text += "`nFailed!!!"
    }



#$objLabelStat.Text = $objDropBoxService.Text
#$x=$objDropBoxService.SelectedItem;$objForm.Close()
})
$objForm.Controls.Add($OKButton)

$objLabelSvc = New-Object System.Windows.Forms.Label
$objLabelSvc.Location = New-Object System.Drawing.Size(10,10) 
$objLabelSvc.Size = New-Object System.Drawing.Size(280,20) 
$objLabelSvc.Text = "Service:"
$objForm.Controls.Add($objLabelSvc) 

$objDropBoxService = New-Object System.Windows.Forms.ComboBox
$objDropBoxService.Location = New-Object System.Drawing.Size(10,30) 
$objDropBoxService.Size = New-Object System.Drawing.Size(260,20) 
$objDropBoxService.Height = 80

[void] $objDropBoxService.Items.Add("TIBCO Administrator 5.9 (ESB_DEV)")
[void] $objDropBoxService.Items.Add("TIBCO Administrator 5.9 (ESB_QA)")
[void] $objDropBoxService.Items.Add("TIBCO EMS Server EMS-DEV-APP-7222")
[void] $objDropBoxService.Items.Add("TIBCO EMS Server EMS-DEV-INFRA-7333")
[void] $objDropBoxService.Items.Add("TIBCO EMS Server EMS-QA-8222")
[void] $objDropBoxService.Items.Add("TIBCO EMS Server EMS-QA-8333")
[void] $objDropBoxService.Items.Add("TIBCO Hawk Agent")
[void] $objDropBoxService.Items.Add("TIBCO Hawk Agent (ESB_DEV)")
[void] $objDropBoxService.Items.Add("TIBCO Hawk Agent (ESB_QA)")
[void] $objDropBoxService.Items.Add("TIBCO Hawk Event")
[void] $objDropBoxService.Items.Add("TIBCO Hawk H2 Database")
[void] $objDropBoxService.Items.Add("TIBCO Hawk HMA")

$objForm.Controls.Add($objDropBoxService) 

$objGroupBoxOpr = New-Object System.Windows.Forms.GroupBox
$objGroupBoxOpr.Location = New-Object System.Drawing.Size(10,60) 
$objGroupBoxOpr.size = New-Object System.Drawing.Size(260,50) 
$objGroupBoxOpr.text = "Service Operation:" 
$objForm.Controls.Add($objGroupBoxOpr) 

$objRadioButtStop = New-Object System.Windows.Forms.RadioButton 
$objRadioButtStop.Location = new-object System.Drawing.Point(10,20) 
$objRadioButtStop.size = New-Object System.Drawing.Size(50,20) 
$objRadioButtStop.Checked = $true 
$objRadioButtStop.Text = "Stop" 
$objGroupBoxOpr.Controls.Add($objRadioButtStop) 

$objRadioButtStart = New-Object System.Windows.Forms.RadioButton
$objRadioButtStart.Location = new-object System.Drawing.Point(65,20)
$objRadioButtStart.size = New-Object System.Drawing.Size(50,20)
$objRadioButtStart.Text = "Start"
$objGroupBoxOpr.Controls.Add($objRadioButtStart)

$objRadioButtRestart = New-Object System.Windows.Forms.RadioButton
$objRadioButtRestart.Location = new-object System.Drawing.Point(120,20)
$objRadioButtRestart.size = New-Object System.Drawing.Size(60,20)
$objRadioButtRestart.Text = "Restart"
$objGroupBoxOpr.Controls.Add($objRadioButtRestart)

$objRadioButtStat = New-Object System.Windows.Forms.RadioButton
$objRadioButtStat.Location = new-object System.Drawing.Point(185,20)
$objRadioButtStat.size = New-Object System.Drawing.Size(60,20)
$objRadioButtStat.Text = "Status"
$objGroupBoxOpr.Controls.Add($objRadioButtStat)

$objGroupBoxStat = New-Object System.Windows.Forms.GroupBox
$objGroupBoxStat.Location = New-Object System.Drawing.Size(10,120) 
$objGroupBoxStat.size = New-Object System.Drawing.Size(260,80) 
$objGroupBoxStat.text = "Status:" 
$objForm.Controls.Add($objGroupBoxStat)

$objLabelStat = New-Object System.Windows.Forms.Label
$objLabelStat.Location = New-Object System.Drawing.Size(10,20) 
$objLabelStat.size = New-Object System.Drawing.Size(240,50) 
$objLabelStat.text = "Label Status:" 
$objGroupBoxStat.Controls.Add($objLabelStat) 


$objForm.Topmost = $True

$objForm.Add_Shown({$objForm.Activate()})
[void] $objForm.ShowDialog()

$x
