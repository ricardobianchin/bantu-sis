unit App.DB.Import.Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas_u, Vcl.ExtCtrls, Vcl.StdCtrls, Sis.UI.IO.Output,
  Sis.UI.IO.Factory, Sis.DB.Import.Origem, Sis.DB.Import, Sis.DB.DBTypes;

type
  TDBImportForm = class(TBasForm)
    TopoPanel: TPanel;
    BasePanel: TPanel;
    MeioPanel: TPanel;
    StatusMemo: TMemo;
  private
    { Private declarations }
    FStatusOutput: IOutput;
    FDBImport: IDBImport;
    FDBImportOrigem: IDBImportOrigem;
  protected
    property StatusOutput: IOutput read FStatusOutput;
    property DBImport: IDBImport read FDBImport;
    property DBImportOrigem: IDBImportOrigem read FDBImportOrigem;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); reintroduce;
  end;

var
  DBImportForm: TDBImportForm;

implementation

{$R *.dfm}

constructor TDBImportForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  FDBImport := pDBImport;
//  FDBImportOrigem := pDBImportOrigem;
//  FStatusOutput := MemoOutputCreate(StatusMemo);
end;

end.
