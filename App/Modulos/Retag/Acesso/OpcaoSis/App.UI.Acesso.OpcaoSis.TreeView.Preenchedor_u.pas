unit App.UI.Acesso.OpcaoSis.TreeView.Preenchedor_u;

interface

uses Sis.UI.Controls.TreeView.Frame.Preenchedor_u, App.AppInfo, Vcl.ComCtrls,
  Sis.UI.Controls.TreeView.Frame_u, Sis.Config.SisConfig, Sis.DB.DBTypes,
  Data.DB, Vcl.Controls, Sis.Types;

type
  TOpcaoSisTreeViewPreenchedor = class(TTreeViewPreenchedor)
  private
    FAppInfo: IAppInfo;
    FSisConfig: ISisConfig;
    FDBMS: IDBMS;
    FDBQuery: IDBQuery;
    FFuncGetSQL: TFunctionString;

    procedure InserirFilhos(pNode: TTreeNode; pOpcaoSisSuperior: integer);
  protected
    procedure ExecNode(pTreeNode: TTreeNode); override;
  public
    procedure PreenchaTreeView(pFiltroId: integer;
      pNovoTitulo: string); override;
    constructor Create(pTreeViewFrame: TTreeViewFrame; pTitulo: string;
      pFuncGetSQL: TFunctionString; pAppInfo: IAppInfo;
      pSisConfig: ISisConfig; pDBMS: IDBMS; pImageList: TImageList);
  end;

implementation

uses App.DB.Utils, Sis.UI.ImgDM, Sis.DB.Factory, System.SysUtils
//  , Sis.Win.Utils_u
  ;

{ TOpcaoSisTreeViewPreenchedor }

constructor TOpcaoSisTreeViewPreenchedor.Create(pTreeViewFrame
  : TTreeViewFrame; pTitulo: string; pFuncGetSQL: TFunctionString;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig; pDBMS: IDBMS;
  pImageList: TImageList);
begin
  inherited Create(pTreeViewFrame, pTitulo, pImageList);
  FAppInfo := pAppInfo;
  FSisConfig := pSisConfig;
  FDBMS := pDBMS;
  FFuncGetSQL := pFuncGetSQL;
end;

procedure TOpcaoSisTreeViewPreenchedor.ExecNode(pTreeNode: TTreeNode);
begin
  if pTreeNode = nil then
    exit;
  inherited;

  if pTreeNode.ImageIndex = 2 then
    pTreeNode.ImageIndex := 3
  else
    pTreeNode.ImageIndex := 2;
end;

procedure TOpcaoSisTreeViewPreenchedor.InserirFilhos(pNode: TTreeNode;
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
      if q.Fields[3].AsBoolean then
      begin
        oNode.ImageIndex := 3;
      end
      else
      begin
        oNode.ImageIndex := 2;
      end;
      q.Next;
    end;
  finally
    FDBQuery.Close;
  end;
end;

procedure TOpcaoSisTreeViewPreenchedor.PreenchaTreeView(pFiltroId: integer;
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
    ('Retag.Acesso.OpcaoSis.OpcaoSis.TreeView.Conn', FSisConfig, FDBMS,
    oDBConnectionParams, nil, nil);
  // Result := inherited;
  // if not Result then
  // exit;

  Resultado := oDBConnection.Abrir;
  if not Resultado then
    exit;
  try
    sSql := FFuncGetSQL;
    //CopyTextToClipboard(sSql);

    FDBQuery := DBQueryCreate('Config.Import.Prod.Rejeicao.Q', oDBConnection,
      sSql, nil, nil);

    //FDBQuery.Params[0].DataType := TFieldType.ftInteger;
    //FDBQuery.Params[1].DataType := TFieldType.ftInteger;

    FDBQuery.Prepare;
    TreeViewFrame.TreeView1.Items.BeginUpdate;
    try
      TreeViewFrame.TreeView1.Items.Clear;
      RaizNode := TreeViewFrame.TreeView1.Items.AddChild(nil, 'Opções do Sistema');
      FDBQuery.Params[1 { perfil_de_uso_id } ].AsInteger := FiltroId;
      InserirFilhos(RaizNode{nil}, 0);
    finally
      FDBQuery.Unprepare;
      TreeViewFrame.TreeView1.Items.EndUpdate;
      TreeViewFrame.AtualizeCaminhoLabel;
    end;
  finally
    oDBConnection.Fechar;
  end;
end;

end.
