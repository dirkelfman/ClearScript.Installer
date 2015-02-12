param($installPath, $toolsPath, $package, $project)



$solutionDir = [System.IO.Path]::GetDirectoryName($dte.Solution.FullName) + "\"
$path = $installPath.Replace($solutionDir, "`$(SolutionDir)")

$NativeAssembliesDir = Join-Path $path "tools/native"

$PostBuildCmd = "if not exist `"`$(TargetDir)`" md `"`$(TargetDir)`"`r`nxcopy /s /d /y `"$NativeAssembliesDir`" `"`$(TargetDir)`""



# Get the current Post Build Event cmd
$currentPostBuildCmd = $project.Properties.Item("PostBuildEvent").Value

# Append our post build command if it's not already there
if (!$currentPostBuildCmd.Contains($PostBuildCmd)) {
    $project.Properties.Item("PostBuildEvent").Value += $PostBuildCmd
}

