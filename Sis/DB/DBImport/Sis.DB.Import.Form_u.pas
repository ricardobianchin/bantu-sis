unit Sis.DB.Import.Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas_u, Vcl.ExtCtrls,
  Vcl.StdCtrls, Sis.UI.IO.Output, Sis.UI.IO.Factory;

type
  TDBImportForm = class(TBasForm)
    TopoPanel: TPanel;
    BasePanel: TPanel;
    MeioPanel: TPanel;
    StatusMemo: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FStatusOutput: IOutput;
  protected
    property StatusOutput: IOutput read FStatusOutput;
  public
    { Public declarations }
  end;

var
  DBImportForm: TDBImportForm;

implementation

{$R *.dfm}

procedure TDBImportForm.FormCreate(Sender: TObject);
begin
  inherited;
  FStatusOutput := MemoOutputCreate(StatusMemo);
end;

end.
