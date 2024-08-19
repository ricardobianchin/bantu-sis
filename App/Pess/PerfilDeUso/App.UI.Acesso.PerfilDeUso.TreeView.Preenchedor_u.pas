unit App.UI.Acesso.PerfilDeUso.TreeView.Preenchedor_u;

interface

uses Sis.UI.Controls.TreeView.Frame.Preenchedor_u, App.AppInfo, Vcl.ComCtrls,
  Sis.UI.Controls.TreeView.Frame_u, Sis.Config.SisConfig, Sis.DB.DBTypes,
  Data.DB, Vcl.Controls, Sis.Types;

type
  TPerfilDeUsoTreeViewPreenchedor = class(TTreeViewPreenchedor)
  private
    FAppInfo: IAppInfo;
    FSisConfig: ISisConfig;
    FDBMS: IDBMS;
    FDBQuery: IDBQuery;
    FFuncGetSQL: TFunctionStringOfObject;

    procedure InserirFilhos(pNode: TTreeNode; pOpcaoSisSuperior: integer);
  protected
  public
    procedure PreenchaTreeView(pFiltroId: integer;
      pNovoTitulo: string); override;
    constructor Create(pTreeViewFrame: TTreeViewFrame; pTitulo: string;
      pFuncGetSQL: TFunctionStringOfObject; pAppInfo: IAppInfo;
      pSisConfig: ISisConfig; pDBMS: IDBMS; pImageList: TImageList);
  end;

implementation

uses App.DB.Utils, Sis.UI.ImgDM, Sis.DB.Factory, System.SysUtils;

{ TPerfilDeUsoTreeViewPreenchedor }

constructor TPerfilDeUsoTreeViewPreenchedor.Create(pTreeViewFrame
  : TTreeViewFrame; pTitulo: string; pFuncGetSQL: TFunctionStringOfObject;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig; pDBMS: IDBMS;
  pImageList: TImageList);
begin
  inherited Create(pTreeViewFrame, pTitulo, pImageList);
  FAppInfo := pAppInfo;
  FSisConfig := pSisConfig;
  FDBMS := pDBMS;
  FFuncGetSQL := pFuncGetSQL;
end;

procedure TPerfilDeUsoTreeViewPreenchedor.InserirFilhos(pNode: TTreeNode;
  pOpcaoSisSuperior: integer);
var
  q: TDataSet;
  oNode: TTreeNode;
  i: integer;
  s: string;
begin
  FDBQuery.Params[0].AsInteger := pOpcaoSisSuperior;
  FDBQuery.Open;
  try
    q := FDBQuery.DataSet;
    if q.IsEmpty then
      exit;
    while not q.Eof do
    begin
      i := q.Fields[0].AsInteger;
      s := Trim(q.Fields[1].AsString);
      oNode := TreeViewFrame.TreeView1.Items.AddChildObject(pNode, s,
        Pointer(i));
      q.Next;
    end;
  finally
    FDBQuery.Close;
  end;
end;

procedure TPerfilDeUsoTreeViewPreenchedor.PreenchaTreeView(pFiltroId: integer;
  pNovoTitulo: string);
var
  oDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
  sSql: string;
var
  Resultado: boolean;
  RaizNode: TTreeNode;
begin
  inherited;
  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
    FAppInfo, FSisConfig);

  oDBConnection := DBConnectionCreate
    ('Retag.Acesso.PerfilDeUso.OpcaoSis.TreeView.Conn', FSisConfig, FDBMS,
    oDBConnectionParams, nil, nil);
  // Result := inherited;
  // if not Result then
  // exit;

  Resultado := oDBConnection.Abrir;
  if not Resultado then
    exit;
  try
    sSql := FFuncGetSQL;

    FDBQuery := DBQueryCreate('Config.Import.Prod.Rejeicao.Q', oDBConnection,
      sSql, nil, nil);
    FDBQuery.Prepare;
    TreeViewFrame.TreeView1.Items.BeginUpdate;
    try
      TreeViewFrame.TreeView1.Items.Clear;
      RaizNode := TreeViewFrame.TreeView1.Items.AddChild(nil,
        'Opções do Sistema');
      FDBQuery.Params[1 { perfil_de_uso_id } ].AsInteger := FiltroId;
      InserirFilhos(RaizNode { nil } , 0);
    finally
      FDBQuery.Unprepare;
      TreeViewFrame.TreeView1.Items.EndUpdate;
    end;
  finally
    oDBConnection.Fechar;
  end;
end;

end.
