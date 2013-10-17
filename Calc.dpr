program Calc;

uses
  Forms,
  uMain in 'uMain.pas' {fmMain},
  uO in 'uO.pas' {fmO};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Калькулятор';
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmO, fmO);
  Application.Run;
end.
