unit Sis.Ui.ImgsList_u;

interface

uses Sis.Ui.ImgsList, System.Generics.Collections;

type
  TImgsList = class(TInterfacedObject, IImgsList)
  private
    FImgDict: TDictionary<Integer, string>;
    FLastIndex: Integer;
    FPastaImg: string;
  public
    function ImgIndexToFileName(pImgIndex: integer): string;
    function PegueImgIndex(pFileName: string): integer;
    constructor Create(pPastaImg: string);
    destructor Destroy; override;
  end;

implementation

{ TImgsList }

constructor TImgsList.Create(pPastaImg: string);
begin
  inherited Create;
  FPastaImg := pPastaImg;
  FImgDict := TDictionary<Integer, string>.Create;
  FLastIndex := 0;
end;

destructor TImgsList.Destroy;
begin
  FImgDict.Free;
  inherited;
end;

function TImgsList.ImgIndexToFileName(pImgIndex: integer): string;
var
  sSubPasta: string;
begin
  Result := '';
  if not FImgDict.TryGetValue(pImgIndex, sSubPasta) then
    exit;
  Result := FPastaImg + sSubPasta;
end;

function TImgsList.PegueImgIndex(pFileName: string): integer;
begin
  Inc(FLastIndex);
  FImgDict.AddOrSetValue(FLastIndex, pFileName);
  Result := FLastIndex;
end;

end.
