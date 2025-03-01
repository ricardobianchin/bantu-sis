unit Sis.DB.FDDataSetManager_u;

interface

uses Sis.DB.FDDataSetManager, Data.DB, FireDAC.Comp.DataSet, Vcl.DBGrids,
  FireDAC.Comp.Client, System.Classes, Sis.Lists.AlignmentList,
  Sis.Lists.IntegerList;

type
  TProcedureDefOfObject = procedure(pParams: TArray<string>) of object;

  TFDDataSetManager = class(TInterfacedObject, IFDDataSetManager)
  private
    FFDMemTable: TFDMemTable;
    FDBGrid: TDBGrid;
    FLargurasList: IIntegerList;
    FAlignmentList: IAlignmentList;

    function FieldCreate(pFieldClass: TFieldClass; pNomeCampo: string;
      pVisible: boolean): TField;

    function AdStringField(pNomeCampo: string; pTamanho: integer;
      pTitulo: string; pAlignment: TAlignment = taLeftJustify;
      pVisible: boolean = True): TField;
    function AdBooleanField(pNomeCampo, pTitulo, pDisplayValues: string;
      pAlignment: TAlignment = taCenter; pVisible: boolean = True): TField;
    function AdIntegerField(pNomeCampo, pTit: string; pMasc: string = '';
      pAlignment: TAlignment = taCenter; pVisible: boolean = True): TField;
    function AdFloatField(pNomeCampo, pTit, pMasc: string;
      pAlignment: TAlignment = taRightJustify;
      pVisible: boolean = True): TField;
    function AdCurrencyField(pNomeCampo, pTit, pMasc: string;
      pAlignment: TAlignment = taRightJustify;
      pVisible: boolean = True): TField;
    function AdDateTimeField(pNomeCampo, pTit, pMasc: string;
      pAlignment: TAlignment = taCenter; pVisible: boolean = True): TField;

    procedure ZereDefs;
    procedure DefinaCampo(pParams: TArray<string>);
    procedure DefinaGridCol(pIndex: integer);
  public
    procedure DefinaCampos(pDefsSL: TStringList);
    procedure PegarDBGrid(pDBGrid: TDBGrid);
    constructor Create(pFDMemTable: TFDMemTable; pDBGrid: TDBGrid = nil);
  end;

implementation

uses System.SysUtils, System.StrUtils, Sis.Types.Integers,
  Sis.UI.Controls.Utils,
  Sis.Lists.Factory, Sis.Types.Bool_u;

{ TFDDataSetManager }

function TFDDataSetManager.AdBooleanField(pNomeCampo, pTitulo,
  pDisplayValues: string; pAlignment: TAlignment;
  pVisible: boolean): TField;
begin
  Result := FieldCreate(TBooleanField, pNomeCampo, pVisible);

  if not pVisible then
    exit;

  Result.Alignment := pAlignment;
  TBooleanField(Result).DisplayLabel := pTitulo;
  TBooleanField(Result).DisplayValues := pDisplayValues;
end;

function TFDDataSetManager.AdCurrencyField(pNomeCampo, pTit, pMasc: string;
  pAlignment: TAlignment; pVisible: boolean): TField;
begin
  Result := FieldCreate(TCurrencyField, pNomeCampo, pVisible);

  if not pVisible then
    exit;

  Result.Alignment := pAlignment;
  TCurrencyField(Result).DisplayFormat := pMasc;
  TCurrencyField(Result).DisplayLabel := pTit;
end;

function TFDDataSetManager.AdDateTimeField(pNomeCampo, pTit, pMasc: string;
  pAlignment: TAlignment; pVisible: boolean): TField;
begin
  Result := FieldCreate(TDateTimeField, pNomeCampo, pVisible);
  if not pVisible then
    exit;

  Result.Alignment := pAlignment;
  TDateTimeField(Result).DisplayFormat := pMasc;
  TDateTimeField(Result).DisplayLabel := pTit;
end;

function TFDDataSetManager.AdFloatField(pNomeCampo, pTit, pMasc: string;
  pAlignment: TAlignment; pVisible: boolean): TField;
begin
  Result := FieldCreate(TFloatField, pNomeCampo, pVisible);

  if not pVisible then
    exit;

  Result.Alignment := pAlignment;
  TFloatField(Result).DisplayLabel := pTit;
  TFloatField(Result).DisplayFormat := pMasc;
end;

function TFDDataSetManager.AdIntegerField(pNomeCampo, pTit, pMasc: string;
  pAlignment: TAlignment; pVisible: boolean): TField;
begin
  Result := FieldCreate(TIntegerField, pNomeCampo, pVisible);

  if not pVisible then
    exit;

  Result.Alignment := pAlignment;

  TIntegerField(Result).DisplayLabel := pTit;
  TIntegerField(Result).DisplayFormat := pMasc;
end;

function TFDDataSetManager.AdStringField(pNomeCampo: string; pTamanho: integer;
  pTitulo: string; pAlignment: TAlignment; pVisible: boolean): TField;
begin
  Result := FieldCreate(TStringField, pNomeCampo, pVisible);
  Result.Size := pTamanho;
  if not pVisible then
    exit;

  TStringField(Result).DisplayLabel := pTitulo;
  Result.Alignment := pAlignment;
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
  sVisibel: string;
  bVisible: boolean;
  sMascara: string;
  sTitulo: string;
  sLargura: string;
  sAlinhamento: string;
  sTamanho: string;

  iTamanho: integer;
  iLargura: integer;
  vAlignment: TAlignment;
  sDisplayValues: string;
  Field: TField;
  sErro: string;
begin
  sIndex := UpperCase(pParams[0]);
  sNomeCampo := UpperCase(pParams[1]);
  sTipo := UpperCase(pParams[2]);
  sVisibel := UpperCase(pParams[4]);

  sMascara := UpperCase(pParams[5]);
  sMascara := ReplaceStr(sMascara, '\V', ',');
  sMascara := ReplaceStr(sMascara, '\\', '\');

  sTitulo := pParams[6];
  sLargura := pParams[7];
  sAlinhamento := UpperCase(pParams[8]);

  bVisible := sVisibel <> 'N';

  if sAlinhamento = '' then
    sAlinhamento := 'E';
  vAlignment := CharToAlignment(sAlinhamento[1]);

  if Length(pParams) >= 10 then
    sDisplayValues := pParams[9]
  else
    sDisplayValues := '';

  if bVisible then
  begin
    iLargura := StrToInteger(sLargura);
    if iLargura < 1 then
      iLargura := 80;

    FLargurasList.Add(iLargura);
    FAlignmentList.Add(vAlignment);
  end;

  if sTipo = 'I' then
  begin
    Field := AdIntegerField(sNomeCampo, sTitulo, sMascara, vAlignment, bVisible);
  end
  else if sTipo = 'S' then
  begin
    sTamanho := pParams[3];
    iTamanho := StrToInteger(sTamanho);
    if iTamanho < 1 then
      raise Exception.Create('Campo string com tamanho zero em ' +
        FFDMemTable.Name);

    Field := AdStringField(sNomeCampo, iTamanho, sTitulo, vAlignment, bVisible);
  end
  else if sTipo = 'B' then
  begin
    if sDisplayValues = '' then
      sDisplayValues := 'Sim;N'#227'o';

    Field := AdBooleanField(sNomeCampo, sTitulo, sDisplayValues, vAlignment, bVisible);
  end
  else if sTipo = 'U' then
  begin
    Field := AdCurrencyField(sNomeCampo, sTitulo, sMascara, vAlignment, bVisible);
  end
  else if sTipo = 'F' then
  begin
    Field := AdFloatField(sNomeCampo, sTitulo, sMascara, vAlignment, bVisible);
  end
  else if sTipo = 'D' then
  begin
    Field := AdDateTimeField(sNomeCampo, sTitulo, sMascara, vAlignment, bVisible);
  end
  else
  begin
    sErro := 'Erro tipo errado:Sis.DB.FDDataSetManager_u'//
      +', TFDDataSetManager.DefinaCampo'//
      +',sIndex='+sIndex//
      +',sNomeCampo='+sNomeCampo//
      +',sTipo='+sTipo//
      ;

    raise Exception.Create(sErro);
    Field := AdDateTimeField(sNomeCampo, sTitulo, sMascara, vAlignment, bVisible);
  end
end;

procedure TFDDataSetManager.DefinaCampos(pDefsSL: TStringList);
var
  sLinhaAtual: string;
  I: integer;
  ProcedureDefGrid: TProcedureDefOfObject;
  Parametros: TArray<string>;
begin
  // ZereDefs;

  FLargurasList.Clear;
  FAlignmentList.Clear;
  for I := 0 to pDefsSL.Count - 1 do
  begin
    sLinhaAtual := pDefsSL[I];
    Parametros := sLinhaAtual.Split([',']);
    Parametros[0] := I.ToString;
    DefinaCampo(Parametros);
  end;

  FFDMemTable.CreateDataSet;

  if not Assigned(FDBGrid) then
    exit;

  PegarDBGrid(FDBGrid);
end;

procedure TFDDataSetManager.DefinaGridCol(pIndex: integer);
var
  oColumn: TColumn;
  sLargura: string;
  iLargura: integer;
  vAlignment: TAlignment;
  oField: TField;
begin
  oColumn := FDBGrid.Columns[pIndex];
  oField := oColumn.Field;
  if not oField.Visible then
    exit;

  vAlignment := FAlignmentList[pIndex];
  oColumn.Alignment := vAlignment;
  oColumn.Title.Alignment := oColumn.Alignment;

  iLargura := FLargurasList[pIndex];
  if iLargura > 0 then
    oColumn.Width := iLargura;
end;

function TFDDataSetManager.FieldCreate(pFieldClass: TFieldClass;
  pNomeCampo: string; pVisible: boolean): TField;
begin
  Result := pFieldClass.Create(FFDMemTable);
  Result.FieldName := pNomeCampo;
  Result.Name := FFDMemTable.Name + Result.FieldName;
  Result.DataSet := FFDMemTable;
  Result.Visible := pVisible;
end;

procedure TFDDataSetManager.PegarDBGrid(pDBGrid: TDBGrid);
var
  I: integer;
begin
  FDBGrid := pDBGrid;

  if Assigned(FDBGrid.DataSource) then
    FDBGrid.DataSource.DataSet := FFDMemTable;

  for I := 0 to FDBGrid.Columns.Count - 1 do
  begin
    DefinaGridCol(I);
  end;
end;

procedure TFDDataSetManager.ZereDefs;
begin
  FFDMemTable.ClearFields;
end;

end.
