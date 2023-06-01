unit btu.lib.files;

interface

function PastaGarantirEntrar(const pCaminho: string): boolean;

implementation

uses System.SysUtils;

function PastaGarantirEntrar(const pCaminho: string): boolean;
begin
  ForceDirectories(pCaminho);

  result := SetCurrentDir(pCaminho);

end;

end.
