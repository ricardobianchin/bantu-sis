unit App.DB.Term.EnviarTabela.ProdBarras_u;

interface

uses Sis.DB.DBTypes, App.DB.Term.EnviarTabela_u, Data.DB {, Data.FmtBcd} ,
  Sis.Entities.Types, App.DB.Term.Registro.ProdBarrasList_u;

type
  TDBConnectionLocation = (loServ, loTerm);
  TResultadoBusca = (rbNaoTem, rbTemDiferente, rbTemIgual);

  TEnvTabProdBarras = class(TEnviarTabela)
  private
    Conn: array [TDBConnectionLocation] of IDBConnection;
    FTabelaNome: string;
    FInsDBExec: IDBExec;
    FAltDBExec: IDBExec;
    FDelDBExec: IDBExec;
    FTermList: TProdBarrasList;
    procedure InicializeCommands;
    procedure LibereCommands;
    procedure PreencherTermList;
    procedure Compare;
    procedure Insira(pCOD_BARRAS: string; pPROD_ID: integer);
    procedure Altere(pCOD_BARRAS: string; pPROD_ID: integer);
    procedure ExcluaRestantes;
  public
    function Execute: boolean; override;
    constructor Create(pServ, pTerm: IDBConnection);
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils, Sis.DB.Factory, Sis.Win.Utils_u, App.DB.Term.Registro.ProdBarras_u;


{ TEnvTabProdBarras }

procedure TEnvTabProdBarras.Altere(pCOD_BARRAS: string; pPROD_ID: integer);
begin
  FAltDBExec.Params[0].AsInteger := pPROD_ID;
  FAltDBExec.Params[1].AsString := pCOD_BARRAS;
  FAltDBExec.Execute;
end;

procedure TEnvTabProdBarras.Compare;
var
  sSql: string;
  Q: TDataSet;
  i: integer;
begin
  sSql := 'SELECT COD_BARRAS, PROD_ID'#13#10 //
    +'FROM PROD_BARRAS'#13#10 //
    +'ORDER BY COD_BARRAS'#13#10 //
    ;

  Conn[loServ].QueryDataSet(sSql, Q);
  try
    while not Q.Eof do
    begin
      i := FTermList.IndexOfValores(Q.Fields[0].AsString, Q.Fields[1].AsInteger);
      if i = -1 then
      begin
        Insira(Q.Fields[0].AsString, Q.Fields[1].AsInteger);
      end
      else
      begin
        FTermList.Delete(i);
      end;
      Q.Next;
    end;
  finally
    Q.Free;
  end;
end;

constructor TEnvTabProdBarras.Create(pServ, pTerm: IDBConnection);
begin
  Conn[loServ] := pServ;
  Conn[loTerm] := pTerm;

  FTabelaNome := 'PROD_BARRAS';
  FTermList := TProdBarrasList.Create;
end;

destructor TEnvTabProdBarras.Destroy;
begin
  FTermList.Free;
  inherited;
end;

procedure TEnvTabProdBarras.ExcluaRestantes;
var
  up: TProdBarras;
  i: integer;
begin
  for i := 0 to FTermList.Count - 1 do
  begin
    up := FTermList[i];
    FDelDBExec.Params[0].AsString := up.COD_BARRAS;
    FDelDBExec.Params[1].AsInteger := up.PROD_ID;
    FDelDBExec.Execute;
  end;
end;

function TEnvTabProdBarras.Execute: boolean;
begin
  InicializeCommands;
  try
    PreencherTermList;
    Compare;
    ExcluaRestantes;
  finally
    LibereCommands;
  end;
end;

procedure TEnvTabProdBarras.InicializeCommands;
var
  sSql: string;
begin
  sSql := //
    'INSERT INTO PROD_BARRAS ('#13#10 //

    + 'COD_BARRAS'#13#10 //
    + ', PROD_ID'#13#10 //

    + ') VALUES (' //

    + ':COD_BARRAS'#13#10 //
    + ', :PROD_ID'#13#10 //

    + ');'#13#10 //
    ;

  FInsDBExec := DBExecCreate('PRBAR.env.ins.exec', Conn[loTerm], sSql, nil, nil);
  FInsDBExec.Prepare;

  sSql := //
    'UPDATE PROD_BARRAS SET'#13#10 //

    + 'PROD_ID = :PROD_ID'#13#10 //

    + 'WHERE COD_BARRAS = :COD_BARRAS'#13#10 //

    + ';'#13#10 //
    ;

  FAltDBExec := DBExecCreate('PRBAR.env.alt.exec', Conn[loTerm], sSql, nil, nil);
  FAltDBExec.Prepare;

  sSql := //
    'DELETE FROM PROD_BARRAS'#13#10 //

    + 'WHERE COD_BARRAS = :COD_BARRAS'#13#10 //
    ;

  FDelDBExec := DBExecCreate('PRBAR.env.del.exec', Conn[loTerm], sSql, nil, nil);
  FDelDBExec.Prepare;
end;

procedure TEnvTabProdBarras.Insira(pCOD_BARRAS: string; pPROD_ID: integer);
begin
  FInsDBExec.Params[0].AsString := pCOD_BARRAS;
  FInsDBExec.Params[1].AsInteger := pPROD_ID;
  FInsDBExec.Execute;
end;

procedure TEnvTabProdBarras.LibereCommands;
begin
  FInsDBExec.Unprepare;
  FAltDBExec.Unprepare;
  FDelDBExec.Unprepare;
end;

procedure TEnvTabProdBarras.PreencherTermList;
var
  sSql: string;
  Q: TDataSet;
begin
  FTermList.Clear;

  sSql := 'SELECT COD_BARRAS, PROD_ID'#13#10 //
    +'FROM PROD_BARRAS'#13#10 //
    +'ORDER BY COD_BARRAS'#13#10 //
    ;
  Conn[loTerm].QueryDataSet(sSql, Q);
  try
    while not Q.Eof do
    begin
      FTermList.Adicionar(Q.Fields[0].AsString, Q.Fields[1].AsInteger);
      Q.Next;
    end;
  finally
    Q.Free;
  end;

end;

end.
