Param(
	[Parameter(Mandatory = $true, HelpMessage = "Angi filsti til kildefil")]
	[Alias("source", "src")]
	[ValidatePattern(".+\.json$")]
	[string]
	$sourcePath,

	[Parameter(Mandatory = $true, HelpMessage = "Angi filsti til destinasjonsfil")]
	[Alias("destination", "dest")]
	[ValidatePattern(".+\.json$")]
	[string]
	$destinationPath,

	[Parameter(HelpMessage="Angi miljø")]
	[Alias("env", "miljø")]
    [ValidateSet("DEV", "TEST", "PROD")]
    [string]
    $environment,

    [Parameter(HelpMessage="Angi url til xxx")]
    [ValidatePattern("^http[s]?://.+")]
    [string]
    $url
)

function Set-Property {
	Param(
		[Parameter(ValueFromPipeline = $true)][psobject] $obj,
		[string] $propertyName,
		$propertyValue
	)
	
	$propertyExists = [bool]($obj.PSobject.Properties.Name -match $propertyName);
	
	if ($propertyExists) {
		$obj.$propertyName = $propertyValue;
	}
	else {
		$obj | Add-Member -NotePropertyName $propertyName -NotePropertyValue $propertyValue
	}
}

$environment = $environment.ToUpperInvariant()

$properties = (Get-Content $sourcePath) -join "`n" | ConvertFrom-Json
$properties | Set-Property -propertyName "environment" -propertyValue $environment
$properties | Set-Property -propertyName "url" -propertyValue $url

$properties | ConvertTo-Json | Out-File -FilePath $destinationPath;