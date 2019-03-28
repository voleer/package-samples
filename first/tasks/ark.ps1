# Emulates Ark execution
# After executing this script, $ark variable can be created as follows:
# $ark = [ArkContext]::new()

class ArkContext {
    # Hashtable that contains task outputs
    $Outputs

    # Constructor
    ArkContext() {
        # Initialize outputs to empty hashtable
        $this.Outputs = @{}
    }

    [void] SetOutputs($outputs) {
        Write-Host "Ark.SetOutputs has been called: $($outputs | out-string)"
        $this.Outputs = $outputs
    }

    # Not strictly necessary, as $ark.Outputs can be used directly
    [void] SetOutput($outputName, $outputValue) {
        Write-Host "Ark.SetOutput has been called: output-name='$outputName' value = $outputValue"
        $this.Outputs[$outputName] = $outputValue
    }
}
