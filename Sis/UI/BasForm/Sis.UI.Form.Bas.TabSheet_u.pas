unit Sis.UI.Form.Bas.TabSheet_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Act_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls;

type
  TTabSheetBasForm = class(TActBasForm)
    TitPanel: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TabSheetBasForm: TTabSheetBasForm;

implementation

{$R *.dfm}

end.
