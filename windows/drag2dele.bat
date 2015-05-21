@echo off

RD /S /Q \\?\%1 || DEL /F /A /Q \\?\%1 