unit Sis.UI.Frame.Bas_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TBasFrame = class(TFrame)
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }

  end;

implementation

{$R *.dfm}

{ TBasFrame }

constructor TBasFrame.Create(AOwner: TComponent);
begin
  inherited;
  ShowHint := True;
end;

end.
