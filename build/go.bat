@echo off
@echo [1/8] Building SwdPageRecorder...

@echo [2/8]    Sharpening knives....
@rem Global variables

set SlnPath=..\SwdPageRecorder\SwdPageRecorder.sln
set SwdUiPath=..\Bin

set EnableNuGetPackageRestore=true

set STDOUT_DEFAULT=build.log
@rem =====================

echo Hello! >%STDOUT_DEFAULT%

@echo [3/8]    Vacuuming a room...
@rem Build/output cleanup



@"C:\Program Files (x86)\MSBuild\12.0\Bin\MSBuild.exe" %SlnPath% /t:clean >>%STDOUT_DEFAULT%
@"C:\Program Files (x86)\MSBuild\12.0\Bin\MSBuild.exe" %SlnPath% >>%STDOUT_DEFAULT%

IF EXIST "SwdPageRecorder_Latest" rd SwdPageRecorder_Latest /Q /S  >>%STDOUT_DEFAULT%
md SwdPageRecorder_Latest >>%STDOUT_DEFAULT%

@rem =====================

@echo [4/8]    Doing some morning exercises...
@Rem 

@REM empty step

@Rem 
@echo [5/8]    Cheving a gum...
@rem !!! Merge all dll files (except WebDriver.dll)  into executable file
set MERGE_LIBS1=%SwdUiPath%\HtmlAgilityPack.dll %SwdUiPath%\Newtonsoft.Json.dll %SwdUiPath%\SwdPageRecorder.WebDriver.dll
set MERGE_LIBS2=%SwdUiPath%\RazorEngine.dll %SwdUiPath%\System.Web.Razor.dll %SwdUiPath%\NLog.dll %SwdUiPath%\FastColoredTextBox.dll
set MERGE_LIBS3=%SwdUiPath%\ClearScript.dll %SwdUiPath%\Cyotek.Windows.Forms.ImageBox.dll


ilmerge\ILMerge.exe /targetplatform:"v4,C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5" /t:winexe /out:SwdPageRecorder_Latest\SwdPageRecorder.exe %SwdUiPath%\SwdPageRecorder.UI.exe  %MERGE_LIBS1% %MERGE_LIBS2% %MERGE_LIBS3% >>%STDOUT_DEFAULT%

@REM Remove SwdPageRecorder.pdb
del /F /Q SwdPageRecorder_Latest\SwdPageRecorder.pdb

@rem =====================

@echo [6/8]    Shovelling coal into the build...
@REM  Copy license, javascript files, code templates and WebDriver.dll

xcopy %SwdUiPath%\JavaScript  SwdPageRecorder_Latest\JavaScript /e/y/i >>%STDOUT_DEFAULT%

xcopy %SwdUiPath%\CodeTemplates  SwdPageRecorder_Latest\CodeTemplates /e/y/i >>%STDOUT_DEFAULT%

xcopy %SwdUiPath%\Snippets  SwdPageRecorder_Latest\Snippets /e/y/i >>%STDOUT_DEFAULT%

copy %SwdUiPath%\NLog.config SwdPageRecorder_Latest\*.* /y >>%STDOUT_DEFAULT%

copy %SwdUiPath%\selenium-server-standalone-2.46.0.jar SwdPageRecorder_Latest\*.* /y >>%STDOUT_DEFAULT%

copy ..\license.md SwdPageRecorder_Latest\license.txt /y >>%STDOUT_DEFAULT%

copy %SwdUiPath%\start_selenium_server.bat SwdPageRecorder_Latest\start_selenium_server.bat /y >>%STDOUT_DEFAULT%

copy %SwdUiPath%\SwdPageRecorder.UI.exe.config SwdPageRecorder_Latest\SwdPageRecorder.exe.config /y >>%STDOUT_DEFAULT%

copy %SwdUiPath%\sample_ParserWebElements.js SwdPageRecorder_Latest\*.* /y >>%STDOUT_DEFAULT%
copy %SwdUiPath%\sample_ParserWebElements.lib.json2.js SwdPageRecorder_Latest\*.* /y >>%STDOUT_DEFAULT%

@REM # Copy WebDriver DLL files

copy %SwdUiPath%\WebDriver.dll SwdPageRecorder_Latest\*.* /y >>%STDOUT_DEFAULT%

@REM #~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~

@echo [7/8]    Cutting the edges...
@REM Compressing the build folder

@REM TODO!!!

@echo [8/8] Build completed.

