unit sis.files.FileInfo_u;

interface

uses sis.files.FileInfo;

type
  TFileInfo = class(TInterfacedObject, IFileInfo)
  private
    FPasta: string;
    FNome: string;
    FData: TDateTime;

    function GetPasta: string;
//    procedure SetPasta(const Value: string);

    function GetNome: string;
//    procedure SetNome(const Value: string);

    function GetData: TDateTime;
//    procedure SetData(const Value: TDateTime);
  public
    function GetCaminhoCompleto: string;

    property Pasta: string read GetPasta {write SetPasta};
    property Nome: string read GetNome {write SetNome};
    property Data: TDateTime read GetData {write SetData};

    procedure PegarDe(pOutroFileInfo: IFileInfo);

    constructor Create(
      pPasta: string;
      pNome: string;
      pData: TDateTime);

  end;

implementation

uses System.SysUtils;

{ TFileInfo }

function TFileInfo.GetPasta: string;
begin
  Result := FPasta;
end;

procedure TFileInfo.PegarDe(pOutroFileInfo: IFileInfo);
begin
  FPasta := pOutroFileInfo.Pasta;
  FNome := pOutroFileInfo.Nome;
  FData := pOutroFileInfo.Data;
end;

{
  procedure TFileInfo.SetPasta(const Value: string);
  begin
    FPasta := Value;
  end;

}
function TFileInfo.GetNome: string;
begin
  Result := FNome;
end;

//procedure TFileInfo.SetNome(const Value: string);
//begin
//  FNome := Value;
//end;

function TFileInfo.GetData: TDateTime;
begin
  Result := FData;
end;

//procedure TFileInfo.SetData(const Value: TDateTime);
//begin
//  FData := Value;
//end;

constructor TFileInfo.Create(pPasta, pNome: string; pData: TDateTime);
begin
  FPasta := pPasta;
  FNome := pNome;
  FData := pData;
end;

function TFileInfo.GetCaminhoCompleto: string;
begin
  Result := IncludeTrailingPathDelimiter(Pasta) + Nome;
end;

end.
