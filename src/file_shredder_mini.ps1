$p = $(Read-Host -Prompt "Enter file path").Trim(); Write-Host ""; if ($p.Length -lt 1) { Write-Host "File is required"; } else { Write-Host "#######################################################################`n#                                                                     #`n#                          File Shredder 1.2                          #`n#                                   by Ivan Sincek                    #`n#                                                                     #`n# GitHub repository at github.com/ivan-sincek/file-shredder.          #`n# Feel free to donate bitcoin at 1BrZM6T7G9RN8vbabnfXu4M6Lpgztq6Y14.  #`n#                                                                     #`n#######################################################################"; $sz = 2048; $b = $null; $rng = $null; $s = $null; $f = $null; try { $f = Get-Item $p -ErrorAction SilentlyContinue; if ($f -eq $null) { Write-Host "Path does not exists"; } elseif ($f -isnot [IO.FileInfo]) { Write-Host "Path specified is not a file"; } else { $f.Attributes = "Normal"; $sec = [Math]::Ceiling($f.Length / $sz); $b = New-Object Byte[] $sz; $rng = New-Object Security.Cryptography.RNGCryptoServiceProvider; $s = New-Object IO.FileStream($f.FullName, [IO.FileAccess]::Write); for ($i = 0; $i -lt 7; $i++) { $s.Position = 0; for ($j = 0; $j -lt $sec; $j++) { $rng.GetBytes($b); $s.Write($b, 0, $b.Length); } } $s.SetLength(0); $s.Close(); $f.CreationTime = "09/06/2069 04:20:00 AM"; $f.LastWriteTime = "09/06/2069 04:20:00 AM"; $f.LastAccessTime = "09/06/2069 04:20:00 AM"; $f.Delete(); Write-Host "File has been shredded successfully"; } } catch { Write-Host $_.Exception.InnerException.Message; } finally { if ($b -ne $null) { $b.Clear(); } if ($rng -ne $null) { $rng.Dispose(); } if ($s -ne $null) { $s.Close(); $s.Dispose(); } if ($f -ne $null) { Clear-Variable -Name "f"; } } }
