program Sorteio;

uses
  Vcl.Forms,
  SistemaSorteioForm in 'SistemaSorteioForm.pas' {fmSistemaSorteio},
  Cliente in 'Model\Cliente.pas',
  Carro in 'Model\Carro.pas',
  Venda in 'Model\Venda.pas',
  ClienteDAO in 'DAO\ClienteDAO.pas',
  CarroDAO in 'DAO\CarroDAO.pas',
  VendasDAO in 'DAO\VendasDAO.pas',
  ClienteService in 'Service\ClienteService.pas',
  SistemaSorteioData in 'Infra\SistemaSorteioData.pas' {dmSistemaSorteio: TDataModule},
  UDFConexaoBancoDados in 'Infra\UDFConexaoBancoDados.pas',
  ConexaoBancoDadosForm in 'ConexaoBancoDadosForm.pas' {fmConexaoBancoDados},
  UDFScripts in 'Infra\UDFScripts.pas',
  UDFUtils in 'UDFUtils.pas',
  CarroService in 'Service\CarroService.pas',
  VendasService in 'Service\VendasService.pas',
  SorteioService in 'Service\SorteioService.pas',
  UDFConstantes in 'UDFConstantes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmSistemaSorteio, dmSistemaSorteio);
  Application.CreateForm(TfmSistemaSorteio, fmSistemaSorteio);
  Application.CreateForm(TfmConexaoBancoDados, fmConexaoBancoDados);
  Application.Run;
end.
