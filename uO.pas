unit uO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, StdCtrls, jpeg, ExtCtrls;

type
  TfmO = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Button1: TButton;
    XPManifest1: TXPManifest;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmO: TfmO;

implementation

{$R *.dfm}

procedure TfmO.Button1Click(Sender: TObject);
begin
  fmO.Close;
end;

end.
