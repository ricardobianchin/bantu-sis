unit App.UI.Frame.Bas.Retag.Ed_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, App.Ent.Ed, Sis.UI.IO.Output;

type
  TRetagEdBasFrame = class(TBasFrame)
  private
    { Private declarations }
    FEntEd: IEntEd;
    FErroOutput: IOutput;
  protected
    function GetEntEd: IEntEd;
    property EntEd: IEntEd read GetEntEd;
    property ErroOutput: IOutput read FErroOutput;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pEntEd: IEntEd; pErroOutput: IOutput); reintroduce;
  end;

var
  RetagEdBasFrame: TRetagEdBasFrame;

implementation

{$R *.dfm}

{ TRetagEdBasFrame }

constructor TRetagEdBasFrame.Create(AOwner: TComponent; pEntEd: IEntEd;
  pErroOutput: IOutput);
begin
  inherited Create(AOwner);
  FEntEd := pEntEd;
  FErroOutput := pErroOutput;
end;

function TRetagEdBasFrame.GetEntEd: IEntEd;
begin
  Result := FEntEd
end;

end.
