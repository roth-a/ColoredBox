{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ColoredBox; 

interface

uses
  UColoredBox, LazarusPackageIntf;

implementation

procedure Register; 
begin
  RegisterUnit('UColoredBox', @UColoredBox.Register); 
end; 

initialization
  RegisterPackage('ColoredBox', @Register); 
end.
