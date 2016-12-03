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

Write-Host $sourcePath
Write-Host $environment
Write-Host $url