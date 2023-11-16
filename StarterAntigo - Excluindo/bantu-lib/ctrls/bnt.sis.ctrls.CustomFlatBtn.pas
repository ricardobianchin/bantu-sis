unit bnt.sis.ctrls.CustomFlatBtn;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.ExtCtrls, bnt.sis.ctrls.FlatBtnFace;

type
  TCustomFlatBtn = class(TCustomPanel)
  private
    { Private declarations }
    FFace: TFlatBtnFace;
  protected
    { Protected declarations }
    property Face: TFlatBtnFace read FFace;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure DoEnter; override;
    procedure DoExit; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;

  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('bntCtrls', [TCustomFlatBtn]);
end;

{ TCustomFlatBtn }

procedure TCustomFlatBtn.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  inherited;
  FFace.Action := Action;
end;

constructor TCustomFlatBtn.Create(AOwner: TComponent);
begin
  inherited;
  TabStop := true;
  caption := ' ';
  BevelOuter := bvNone;
  Width := 150;
  Height := 50;
  StyleElements := [];
  Parent := TWinControl(AOwner);
  FFace := TFlatBtnFace.Create(Self);

end;

procedure TCustomFlatBtn.DoEnter;
begin
  inherited;
  FFace.Focused := true;
end;

procedure TCustomFlatBtn.DoExit;
begin
  inherited;
  FFace.Focused := false;
end;

end.
