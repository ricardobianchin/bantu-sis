unit Sis.DB.FDDataSetManager_u;

interface

uses Sis.DB.FDDataSetManager, Data.DB, FireDAC.Comp.DataSet, Vcl.DBGrids,
  FireDAC.Comp.Client, System.Classes, Sis.Lists.AlignmentList, Sis.Lists.IntegerList;

type
  TProcedureDefOfObject = procedure(pParams: TArray<string>) of object;

  TFDDataSetManager = class(TInterfacedObject, IFDDataSetManager)
  private
    FFDMemTable: TFDMemTable;
    FDBGrid: TDBGrid;
    FLargurasList: IIntegerList;
    FAlignmentList: IAlignmentList;

    function AdIntegerFieldInvisivel(pNomeCampo: string): TField;
    function AdStringFieldInvisivel(pNomeCampo: string;
      pTamanho: integer): TField;

    procedure AdStringField(pNomeCampo: string; pTamanho: integer;
      pTitulo: string; pAlignment: TAlignment = taLeftJustify);

    procedure ZereDefs;
    procedure DefinaCampo(pParams: TArray<string>);
    procedure DefinaGridCol(pIndex: integer);
  public
    procedure DefinaCampos(pDefsSL: TStringList);
    constructor Create(pFDMemTable: TFDMemTable; pDBGrid: TDBGrid);
  end;

implementation

uses System.SysUtils, System.StrUtils, Sis.Types.Integers, Sis.UI.Controls.Utils,
  Sis.Lists.Factory;

{ TFDDataSetManager }

function TFDDataSetManager.AdIntegerFieldInvisivel(pNomeCampo: string): TField;
begin
  Result := TIntegerField.Create(FFDMemTable);
  Result.FieldName := pNomeCampo;
  Result.Name := FFDMemTable.Name + Result.FieldName;
  Result.DataSet := FFDMemTable;
end;

procedure TFDDataSetManager.AdStringField(pNomeCampo: string; pTamanho: integer;
  pTitulo: string; pAlignment: TAlignment);
var
  oField: TField;
begin
  oField := AdStringFieldInvisivel(pNomeCampo, pTamanho);
  TStringField(oField).DisplayLabel := pTitulo;
  oField.Alignment := pAlignment;
end;

function TFDDataSetManager.AdStringFieldInvisivel(pNomeCampo: string;
  pTamanho: integer): TField;
begin
  Result := TStringField.Create(FFDMemTable);
  Result.FieldName := pNomeCampo;
  Result.Name := FFDMemTable.Name + Result.FieldName;
  Result.DataSet := FFDMemTable;
  Result.Size := pTamanho;
end;

constructor TFDDataSetManager.Create(pFDMemTable: TFDMemTable;
  pDBGrid: TDBGrid);
begin
  FFDMemTable := pFDMemTable;
  FDBGrid := pDBGrid;
  FAlignmentList := AlignmentListCreate;
  FLargurasList := IntegerListCreate;
end;

procedure TFDDataSetManager.DefinaCampo(pParams: TArray<string>);
var
  sIndex: string;
  sNomeCampo: string;
  sTipo: string;
  sVisivel: string;
  sMascara: string;
  sTitulo: string;
  sLargura: string;
  sAlinhamento: string;
  sTamanho: string;
  
  iTamanho: integer;
  iLargura: integer;
  vAlignment: TAlignment;
  Field: TField;
begin
  sIndex := UpperCase(pParams[0]);
  sNomeCampo := UpperCase(pParams[1]);
  sTipo := UpperCase(pParams[2]);
  sVisivel := UpperCase(pParams[4]);
  sTitulo := pParams[6];
  sLargura := pParams[7];
  
  sAlinhamento := UpperCase(pParams[8]);
  if sAlinhamento = '' then
    sAlinhamento := 'E';
  vAlignment := CharToAlignment(sAlinhamento[1]);

  iLargura := StrToInteger(sLargura);
  
  FLargurasList.Add(iLargura);
  FAlignmentList.Add(vAlignment);

  if sTipo = 'I' then
  begin
    Field := AdIntegerFieldInvisivel(sNomeCampo);
    if sVisivel = 'N' then
      Exit
  end
  else if sTipo = 'S' then
  begin
    sTamanho := pParams[3];
    iTamanho := StrToInteger(sTamanho);
    if iTamanho < 1 then
      raise Exception.Create('Campo string com tamanho zero em '+FFDMemTable.Name);
    if sVisivel = 'N' then
      Field := AdStringFieldInvisivel(sNomeCampo, iTamanho)
    else
      AdStringField(sNomeCampo, iTamanho, sTitulo, vAlignment)  
  end;
end;

procedure TFDDataSetManager.DefinaCampos(pDefsSL: TStringList);
var
  sLinhaAtual: string;
  I: integer;
  ProcedureDefGrid: TProcedureDefOfObject;
  Parametros: TArray<string>;
begin
//  ZereDefs;

  FLargurasList.Clear;
  FAlignmentList.Clear;
  for I := 2 to pDefsSL.Count - 1 do
  begin
    sLinhaAtual := pDefsSL[I];
    Parametros := sLinhaAtual.Split([',']);
    DefinaCampo(Parametros);
  end;

  FFDMemTable.CreateDataSet;

  if not Assigned(FDBGrid) then
    exit;    
    
  if Assigned(FDBGrid.DataSource) then
    FDBGrid.DataSource.DataSet := FFDMemTable;
      
  for I := 0 to FDBGrid.Columns.Count - 1 do
  begin
    DefinaGridCol(I);
  end;
end;

procedure TFDDataSetManager.DefinaGridCol(pIndex: integer);
var
  oColumn: TColumn;
  sLargura: string;
  iLargura: integer;
  vAlignment: TAlignment;
begin
  oColumn := FDBGrid.Columns[pIndex];
  iLargura := FLargurasList[pIndex];
  if iLargura = 0 then
  begin
    oColumn.Visible := False;
    exit;
  end;

  oColumn.Visible := True;

  oColumn.Width := iLargura;
  
  vAlignment := FAlignmentList[pIndex];
  oColumn.Alignment := vAlignment;
end;

procedure TFDDataSetManager.ZereDefs;
begin
  FFDMemTable.ClearFields;
end;

end.
