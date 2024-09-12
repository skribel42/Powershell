Add-Type -AssemblyName System.Windows.Forms

# Create a new form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Restart Required"
$form.Size = New-Object System.Drawing.Size(450,200)  # Increased size to fit content better
$form.StartPosition = "CenterScreen"
$form.ControlBox = $false  # Disable the close button

# Add a label to the form
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(420,60)  # Increased size to fit content better
$label.Text = "To ensure the security and performance of your system, a restart is necessary to complete recent updates.`nPlease choose an option:"
$label.AutoSize = $true
$label.MaximumSize = New-Object System.Drawing.Size(420, 0)  # Allow text wrapping
$form.Controls.Add($label)

# Add custom buttons
$button1 = New-Object System.Windows.Forms.Button
$button1.Location = New-Object System.Drawing.Point(80,100)  # Adjusted position
$button1.Size = New-Object System.Drawing.Size(120,30)  # Adjusted size to fit text better
$button1.Text = "Restart Now"
$button1.DialogResult = [System.Windows.Forms.DialogResult]::Yes
$form.Controls.Add($button1)

$button2 = New-Object System.Windows.Forms.Button
$button2.Location = New-Object System.Drawing.Point(220,100)  # Adjusted position
$button2.Size = New-Object System.Drawing.Size(150,30)  # Adjusted size to fit text better
$button2.Text = "Restart in 60 Minutes"
$button2.DialogResult = [System.Windows.Forms.DialogResult]::No
$form.Controls.Add($button2)

# Add a default button to make it easier for users to press Enter
$form.AcceptButton = $button1

# Show the form as a dialog box and capture the result
$result = $form.ShowDialog()

# Loop to prevent form closure until valid choice is made
while ($result -ne [System.Windows.Forms.DialogResult]::Yes -and
       $result -ne [System.Windows.Forms.DialogResult]::No) {
    $result = $form.ShowDialog()
}

# Process user's choice
if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
    # User clicked "Restart Now"
    Restart-Computer -Force
}
elseif ($result -eq [System.Windows.Forms.DialogResult]::No) {
    # User clicked "Restart in 60 Minutes"
    $messageLater = "Your computer will restart in 60 minutes.`nPlease save your work."
    $captionLater = "Restart Reminder"
    [System.Windows.Forms.MessageBox]::Show($messageLater, $captionLater, [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)

    # Schedule a restart after 60 minutes
    Start-Sleep -Seconds 3600
    Restart-Computer -Force
}

# Clean up the form
$form.Dispose()
