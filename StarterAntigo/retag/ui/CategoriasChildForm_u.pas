unit CategoriasChildForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ChildForm_u, Data.DB, Vcl.ToolWin,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, System.Actions, Vcl.ActnList, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Stan.StorageBin,
  FireDAC.DApt, Vcl.Mask;

type
  TCategoriasChildForm = class(TChildForm)
    FDMemTable1ID: TLargeintField;
    FDMemTable1Descr: TStringField;
    procedure InsActionExecute(Sender: TObject);
    procedure AlterarActionExecute(Sender: TObject);
    procedure FecharActionExecute(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure Carregar; override;
  public
    { Public declarations }
  end;

var
  CategoriasChildForm: TCategoriasChildForm;

implementation

{$R *.dfm}

uses CategoriasDiagForm_u;

{ TCategoriasChildForm }

procedure TCategoriasChildForm.AlterarActionExecute(Sender: TObject);
var
  sNome, sSqlUpdate: string;
  i: Int64;
  Q: TDataSet;
begin
  inherited;
  if FDMemTable1.isempty then
    exit;

  sNome := Trim(FDMemTable1Descr.AsString);
  if not CategoriasDiagForm_u.Editar(sNome) then
    exit;

  if not Conectou then
    exit;
  try
    try
      i := FDMemTable1.Fields[0].AsLargeInt;
      sSqlUpdate := 'UPDATE PROD_CATEG SET NOME = ' + QuotedStr(sNome) + ' WHERE PROD_CATEG_ID =' + i.ToString +';';
      FDConnection1.ExecSQL(sSqlUpdate);
    finally
      Carregar;
      FDMemTable1.Locate('ID', VarArrayOf([I]),[loCaseInsensitive]);
    end;
  finally
    Desconectar;
  end;
end;

procedure TCategoriasChildForm.Carregar;
var
  s: string;
  Q: TDataSet;
begin
  s := 'select PROD_CATEG_ID,NOME from PROD_CATEG';

  if FiltroLabeledEdit.Text<>'' then
  begin
    s := s + ' where nome like ''%' + FiltroLabeledEdit.Text + '%''';
  end;

  s := s + ' ORDER BY NOME';
  FDConnection1.ExecSQL(s, Q);
  try
    FDMemTable1.Active := true;
    FDMemTable1.EmptyDataSet;
    FDMemTable1.DisableControls;
    while not Q.Eof do
    begin
      FDMemTable1.Append;
      FDMemTable1ID.AsLargeInt := Q.Fields[0].AsLargeInt;
      FDMemTable1Descr.AsString := trim(Q.Fields[1].AsString);
      FDMemTable1.post;

      Q.Next;
    end;
  finally
    FDMemTable1.First;
    FDMemTable1.EnableControls;
    Q.Free;
  end;
end;

procedure TCategoriasChildForm.FecharActionExecute(Sender: TObject);
begin
//  inherited;
  Parent.Free;

end;

procedure TCategoriasChildForm.InsActionExecute(Sender: TObject);
var
  sNome, sSqlNextValue, sSqlqInsert: string;
  i: Int64;
  Q: TDataSet;
begin
  inherited;
  sNome := '';
  if not CategoriasDiagForm_u.Editar(sNome) then
    exit;

  if not Conectou then
    exit;
  try
    try
      sSqlNextValue := 'SELECT NEXT VALUE FOR PROD_CATEG_G FROM RDB$DATABASE;';
      FDConnection1.ExecSQL(sSqlNextValue, Q);
      if Q.IsEmpty then
        raise Exception.Create('Erro gerando novo registro');
      i := Q.Fields[0].AsLargeInt;
      q.Free;
      sSqlqInsert := 'INSERT INTO PROD_CATEG(PROD_CATEG_ID,NOME) VALUES (' +
        i.ToString + ', ' + QuotedStr(sNome) + ');';
      FDConnection1.ExecSQL(sSqlqInsert);
    finally
      Carregar;
      FDMemTable1.Locate('Nome', VarArrayOf([sNome]),[loCaseInsensitive]);
    end;
  finally
    Desconectar;
  end;
end;

end.
