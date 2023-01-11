If ($True) {

  $MANFILE = "${env:REPOS_DIR}/Coding/man/dism.exe.help.man";
  $DASH_NL = "------------------------------------------------------------`n";

  Set-Content -Path ("${MANFILE}") -Value ("${DASH_NL}");

  $DISM_ARGS=@("/Online","/?");  Add-Content -Path ("${MANFILE}") -Value ("DISM ${DISM_ARGS}");  DISM ${DISM_ARGS} | Add-Content -Path ("${MANFILE}");  Add-Content -Path ("${MANFILE}") -Value ("${DASH_NL}");
  $DISM_ARGS=@("/Online","/Cleanup-Image","/?");  Add-Content -Path ("${MANFILE}") -Value ("DISM ${DISM_ARGS}");  DISM ${DISM_ARGS} | Add-Content -Path ("${MANFILE}");  Add-Content -Path ("${MANFILE}") -Value ("${DASH_NL}");
  $DISM_ARGS=@("/Online","/Enable-Feature","/?");  Add-Content -Path ("${MANFILE}") -Value ("DISM ${DISM_ARGS}");  DISM ${DISM_ARGS} | Add-Content -Path ("${MANFILE}");  Add-Content -Path ("${MANFILE}") -Value ("${DASH_NL}");
  $DISM_ARGS=@("/Online","/Get-WimInfo","/?");  Add-Content -Path ("${MANFILE}") -Value ("DISM ${DISM_ARGS}");  DISM ${DISM_ARGS} | Add-Content -Path ("${MANFILE}");  Add-Content -Path ("${MANFILE}") -Value ("${DASH_NL}");

}