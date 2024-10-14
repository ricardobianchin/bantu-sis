unit App.DB.Term.EnviarTabela.UsuarioTemPerfilDeUso_u;

interface

uses Sis.DB.DBTypes, App.DB.Term.EnviarTabela_u, Data.DB {, Data.FmtBcd} ,
  Sis.Entities.Types, App.DB.Term.Registro.UsuarioTemPerfilDeUsoList_u;

type

  TDBConnectionLocation = (loServ, loTerm);
  TResultadoBusca = (rbNaoTem, rbTemDiferente, rbTemIgual);

  TEnvTabUsuarioTemPerfilDeUso = class(TEnviarTabela)
  private
    Conn: array [TDBConnectionLocation] of IDBConnection;
    FTabelaNome: string;
    FInsDBExec: IDBExec;
    FDelDBExec: IDBExec;
    FTermList: TUsuarioTemPerfilDeUsoListList;
    procedure InicializeCommands;
    procedure LibereCommands;
    procedure PreencherTermList;
    procedure Compare;
    procedure Insira(pLOJA_ID: TLojaId; pPESSOA_ID: integer; pPERFIL_DE_USO_ID: integer);
    procedure ExcluaRestantes;
  public
    function Execute: boolean; override;
    constructor Create(pServ, pTerm: IDBConnection);
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils, Sis.DB.Factory, Sis.Win.Utils_u, App.DB.Term.Registro.UsuarioTemPerfilDeUso_u;

{ TEnvTabUsuarioTemPerfilDeUso }

procedure TEnvTabUsuarioTemPerfilDeUso.Compare;
var
  sSql: string;
  Q: TDataSet;
  i: integer;
begin
  FTermList.Clear;

  sSql := 'SELECT LOJA_ID, PESSOA_ID, PERFIL_DE_USO_ID'#13#10 //
    +'FROM USUARIO_TERM_PERFIL_DE_USO'#13#10 //
    +'ORDER BY LOJA_ID, TERMINAL_ID, PESSOA_ID, PERFIL_DE_USO_ID'#13#10 //
    ;

  Conn[loServ].QueryDataSet(sSql, Q);
  try
    while not Q.Eof do
    begin
      i := FTermList.IndexOfValores(Q.Fields[0].AsInteger, Q.Fields[1].AsInteger, Q.Fields[2].AsInteger);
      if i = -1 then
      begin
        Insira(Q.Fields[0].AsInteger, Q.Fields[1].AsInteger, Q.Fields[2].AsInteger);
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

constructor TEnvTabUsuarioTemPerfilDeUso.Create(pServ, pTerm: IDBConnection);
begin
  Conn[loServ] := pServ;
  Conn[loTerm] := pTerm;

  FTabelaNome := 'USUARIO_TEM_PERFIL_DE_USO';
  FTermList := TUsuarioTemPerfilDeUsoListList.Create;
end;

destructor TEnvTabUsuarioTemPerfilDeUso.Destroy;
begin
  FTermList.Free;
  inherited;
end;

procedure TEnvTabUsuarioTemPerfilDeUso.ExcluaRestantes;
var
  up: TUsuarioTemPerfilDeUso;
  i: integer;
begin
  for i := 0 to FTermList.Count - 1 do
  begin
    up := FTermList[i];
    FDelDBExec.Params[0].AsSmallInt := up.LOJA_ID;
    FDelDBExec.Params[1].AsInteger := up.PESSOA_ID;
    FDelDBExec.Params[2].AsInteger := up.PERFIL_DE_USO_ID;
    FDelDBExec.Execute;
  end;
end;

function TEnvTabUsuarioTemPerfilDeUso.Execute: boolean;
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

procedure TEnvTabUsuarioTemPerfilDeUso.InicializeCommands;
var
  sSql: string;
begin
  sSql := //
    'INSERT INTO USUARIO_TEM_PERFIL_DE_USO ('#13#10 //

    + 'LOJA_ID'#13#10 //
    + ', TERMINAL_ID'#13#10 //
    + ', PESSOA_ID'#13#10 //
    + ', PERFIL_DE_USO_ID'#13#10 //

    + ') VALUES (' //

    + ':LOJA_ID'#13#10 //
    + ', 0'#13#10 //
    + ', :PESSOA_ID'#13#10 //
    + ', :PERFIL_DE_USO_ID'#13#10 //

    + ');'#13#10 //
    ;

  FInsDBExec := DBExecCreate('upos.env.ins.exec', Conn[loTerm], sSql, nil, nil);
  FInsDBExec.Prepare;

  sSql := //
    'DELETE FROM USUARIO_TEM_PERFIL_DE_USO'#13#10 //

    + 'WHERE LOJA_ID = :LOJA_ID'#13#10 //
    + 'AND TERMINAL_ID = 0'#13#10 //
    + 'AND PESSOA_ID = :PESSOA_ID'#13#10 //
    + 'AND PERFIL_DE_USO_ID = :PERFIL_DE_USO_ID;'#13#10 //
    ;

  FDelDBExec := DBExecCreate('upos.env.del.exec', Conn[loTerm], sSql, nil, nil);
  FDelDBExec.Prepare;
end;

procedure TEnvTabUsuarioTemPerfilDeUso.Insira(pLOJA_ID: TLojaId; pPESSOA_ID,
  pPERFIL_DE_USO_ID: integer);
begin
  FInsDBExec.Params[0].AsSmallInt := pLOJA_ID;
  FInsDBExec.Params[1].AsInteger := pPESSOA_ID;
  FInsDBExec.Params[2].AsInteger := pPERFIL_DE_USO_ID;
  FInsDBExec.Execute;
end;

procedure TEnvTabUsuarioTemPerfilDeUso.LibereCommands;
begin
  FInsDBExec.Unprepare;
  FDelDBExec.Unprepare;
end;

procedure TEnvTabUsuarioTemPerfilDeUso.PreencherTermList;
var
  sSql: string;
  Q: TDataSet;
begin
  FTermList.Clear;

  sSql := 'SELECT LOJA_ID, PESSOA_ID, PERFIL_DE_USO_ID'#13#10 //
    +'FROM USUARIO_TEM_PERFIL_DE_USO'#13#10 //
    +'ORDER BY LOJA_ID, TERMINAL_ID, PESSOA_ID, PERFIL_DE_USO_ID'#13#10 //
    ;
  Conn[loTerm].QueryDataSet(sSql, Q);
  try
    while not Q.Eof do
    begin
      FTermList.Adicionar(Q.Fields[0].AsInteger, Q.Fields[1].AsInteger, Q.Fields[2].AsInteger);
      Q.Next;
    end;
  finally
    Q.Free;
  end;
end;

end.
