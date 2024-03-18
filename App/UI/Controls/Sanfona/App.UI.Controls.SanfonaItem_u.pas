unit App.UI.Controls.SanfonaItem_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.Controls.SanfonaItem_u,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,
  Vcl.ExtCtrls, App.Ent.Ed, Sis.UI.IO.Output;

type
  TSanfonaItemFrame = class(TSanfonaItemBasFrame)
  private
    { Private declarations }
    FEntEd: IEntEd;
  protected
    function GetEntEd: IEntEd;
    property EntEd: IEntEd read GetEntEd;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pEntEd: IEntEd; pErroOutput: IOutput); reintroduce;
  end;

//var
//  SanfonaItemBasFrame1: TSanfonaItemBasFrame1;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM;

{ TSanfonaItemBasFrame1 }

constructor TSanfonaItemFrame.Create(AOwner: TComponent; pEntEd: IEntEd; pErroOutput: IOutput);
begin
  inherited Create(AOwner);
//  inherited Create(AOwner, pErroOutput);
  FEntEd := pEntEd;
end;

function TSanfonaItemFrame.GetEntEd: IEntEd;
begin
  Result := FEntEd
end;

end.
