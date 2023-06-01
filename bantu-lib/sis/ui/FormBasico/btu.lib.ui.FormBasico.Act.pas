unit btu.lib.ui.FormBasico.Act;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions,
  Vcl.ActnList, btu.lib.ui.FormBasico;

type
  TFormBasAct = class(TFormBasico)
    BasActActionList: TActionList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBasAct: TFormBasAct;

implementation

{$R *.dfm}

end.
