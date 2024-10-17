unit Sis.Treads.StatusFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, Vcl.StdCtrls;

type
  TStatusFrame = class(TBasFrame)
    TitLabel: TLabel;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pNovoName: string); reintroduce;
  end;

//var
//  StatusFrame: TStatusFrame;

implementation

{$R *.dfm}

{ TStatusFrame }

constructor TStatusFrame.Create(AOwner: TComponent; pNovoName: string);
begin
  Name := pNovoName;
  inherited Create(AOwner);
end;

end.
