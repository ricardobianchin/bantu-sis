unit App.UI.Form.TreeView.Retag.Acesso.OpcaoSis_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Data.DB, App.AppObj, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Sis.UI.Form.Bas.Diag.Btn.TreeView_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Sis.DB.DBTypes;

type
  TOpcaoSisTreeViewForm = class(TTreeViewDiagBasForm)
    procedure OkAct_DiagExecute(Sender: TObject);
  private
    { Private declarations }
    FAssociadaId: integer;
    FAssociadaNome: string;

    FAppObj: IAppObj;
    FDBMS: IDBMS;
    FDBConnection: IDBConnection;
    FDBQuery: IDBQuery;


    procedure Gravar;
  protected
    property AssociadaId: integer read FAssociadaId;
    property AssociadaNome: string read FAssociadaNome;

    procedure PreencherTreeView; override;
    function GetSql: string; virtual; abstract;
    function GetSqlGravar: string; virtual; abstract;

    procedure InserirFilhos(pNodePai: TTreeNode; pOpcaoSisIdSuperior: integer);

    function GetEntidadeAssociada: string; virtual; abstract;
    function NodesListAsString: string;
    property AppObj: IAppObj read FAppObj;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent;
      pAssociadaId: integer; pAssociadaNome: string; pAppObj: IAppObj;
      pDBMS: IDBMS); reintroduce; virtual;
  end;

var
  OpcaoSisTreeViewForm: TOpcaoSisTreeViewForm;

implementation

{$R *.dfm}

uses App.DB.Utils, Sis.UI.ImgDM, Sis.DB.Factory, Sis.Sis.Constants
  // , Sis.Win.Utils_u
    ;

constructor TOpcaoSisTreeViewForm.Create(AOwner: TComponent;
  pAssociadaId: integer; pAssociadaNome: string; pAppObj: IAppObj;
  pDBMS: IDBMS);
var
  sCaption: TCaption;
  sTitulo: TCaption;
  oDBConnectionParams: TDBConnectionParams;
begin
  FAssociadaId := pAssociadaId;
  FAssociadaNome := pAssociadaNome;

  sCaption := 'Opções do Sistema para o ' + GetEntidadeAssociada;
  sTitulo := GetEntidadeAssociada + ': ' + FAssociadaId.ToString + ' - ' +
    FAssociadaNome;

  inherited Create(AOwner, sCaption, sTitulo);

  TreeView1.CheckBoxes := True;

  FAppObj := pAppObj;
  FDBMS := pDBMS;

  oDBConnectionParams := TerminalIdToDBConnectionParams(TERMINAL_ID_RETAGUARDA,
    FAppObj);

  FDBConnection := DBConnectionCreate
    ('Retag.Acesso.OpcaoSis.OpcaoSis.TreeView.Conn', FAppObj.SisConfig,
    oDBConnectionParams, nil, nil);
end;

procedure TOpcaoSisTreeViewForm.Gravar;
var
  sSql: string;
  Resultado: boolean;
  oDBExec: IDBExec;
begin
  inherited;

  Resultado := FDBConnection.Abrir;
  if not Resultado then
    exit;

  try
    sSql := GetSqlGravar;

    oDBExec := DBExecCreate('Config.Import.Prod.Rejeicao.Exec', FDBConnection,
      sSql, nil, nil);

    oDBExec.Execute;
  finally
    FDBConnection.Fechar;
  end;
end;

procedure TOpcaoSisTreeViewForm.InserirFilhos(pNodePai: TTreeNode;
  pOpcaoSisIdSuperior: integer);
var
  q: TDataSet;
  oNovoNode: TTreeNode;
  iOpcaoSis: integer;
  sOpacaoNome: string;
  bOpcaoPode: Boolean;
begin
  FDBQuery.Params[0].AsInteger := pOpcaoSisIdSuperior;
  FDBQuery.Open;
  try
    q := FDBQuery.DataSet;
    if q.IsEmpty then
      exit;
    while not q.Eof do
    begin
      iOpcaoSis := q.Fields[0].AsInteger;
      sOpacaoNome := Trim(q.Fields[1].AsString);
      bOpcaoPode := q.Fields[3].AsBoolean;

      oNovoNode := AddChildNode(pNodePai, sOpacaoNome, Pointer(iOpcaoSis));
//      oNovoNode := TreeView1.Items.AddChildObject(pNodePai, s, Pointer(i));

      oNovoNode.Checked := bOpcaoPode;
      q.Next;
    end;
  finally
    FDBQuery.Close;
  end;
end;

function TOpcaoSisTreeViewForm.NodesListAsString: string;
var
  i: integer;
  iOpcaoSisId: integer;
  bOpcaoPode: boolean;
  oNodeAtual: TTreeNode;
begin
  Result := '';
  for I := 0 to NodeList.Count - 1 do
  begin
    oNodeAtual := NodeList[I];
    bOpcaoPode := oNodeAtual.Checked;
    if bOpcaoPode then
    begin
      iOpcaoSisId := integer(oNodeAtual.Data);

      if Result <> '' then
        Result := Result + ';';
      Result := Result + iOpcaoSisId.ToString;
    end;
  end;
end;

procedure TOpcaoSisTreeViewForm.OkAct_DiagExecute(Sender: TObject);
begin
  Gravar;
  inherited;

end;

procedure TOpcaoSisTreeViewForm.PreencherTreeView;
var
  sSql: string;
  Resultado: boolean;
//  RaizNode: TTreeNode;
//  sRaizNodeText: string;
begin
  inherited;

  Resultado := FDBConnection.Abrir;
  if not Resultado then
    exit;

  try
    sSql := GetSql;
    // CopyTextToClipboard(sSql);

    FDBQuery := DBQueryCreate('Config.Import.Prod.Rejeicao.Q', FDBConnection,
      sSql, nil, nil);

    FDBQuery.Prepare;
    TreeView1.Items.BeginUpdate;
    try
      TreeView1.Items.Clear;
      //sRaizNodeText := 'Opções do Sistema para ' + FPerfilDeUsoNome;

      //RaizNode := TreeView1.Items.AddChild(nil, sRaizNodeText);
      FDBQuery.Params[1 { associada id } ].AsInteger := FAssociadaId;
      InserirFilhos({RaizNode} nil, 0);
      TreeView1.Select(TreeView1.Items.GetFirstNode);
    finally
      FDBQuery.Unprepare;
      TreeView1.Items.EndUpdate;
      AtualizeCaminho;
      //RaizNode.Expand(False);
    end;
  finally
    FDBConnection.Fechar;
  end;
end;

end.
