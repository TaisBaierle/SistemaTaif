unit ConexaoBancoDadosForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.Buttons;

type
  TfmConexaoBancoDados = class(TForm)
    paCentro: TPanel;
    lbTitulo: TLabel;
    lbCaminhoBancoDados: TLabel;
    edCaminhoServidor: TMaskEdit;
    lbUsuarioBancoDados: TLabel;
    edUsuarioBD: TMaskEdit;
    lbSenhaBancoDados: TLabel;
    edSenhaBD: TMaskEdit;
    btSelecionar: TButton;
    btExibir: TButton;
    btSalvar: TButton;
    btCancelar: TButton;
    OpenDialog: TOpenDialog;
    procedure btCancelarClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btSelecionarClick(Sender: TObject);
    procedure btExibirClick(Sender: TObject);
  private

  public

  end;

var
  fmConexaoBancoDados: TfmConexaoBancoDados;

implementation

{$R *.dfm}

uses
  UDFConexaoBancoDados,  FileCtrl;

procedure TfmConexaoBancoDados.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfmConexaoBancoDados.btExibirClick(Sender: TObject);
begin
  if btExibir.Caption = 'Exibir' then
  begin
    btExibir.Caption := 'Ocultar';
    edSenhaBD.PasswordChar := #0;
  end
  else
  begin
    btExibir.Caption := 'Exibir';
    edSenhaBD.PasswordChar := '*';
  end;
end;

procedure TfmConexaoBancoDados.btSalvarClick(Sender: TObject);
var
  LConexao: TConexao;
begin
  if (edCaminhoServidor.Text = '') or (edUsuarioBD.Text = '') or
    (edSenhaBD.Text = '') then
  begin
    MessageDlg('Todos campos devem ser preenchidos!', mtInformation, [mbOK], 0);
  end
  else
  begin
    if (edUsuarioBD.Text = 'SYSDBA') and (edSenhaBD.Text = 'masterkey') then
    begin
      LConexao := TConexao.Create(ExtractFilePath(Application.ExeName) +
        'Config.ini');
      try
        LConexao.GravarINI(edUsuarioBD.Text, edSenhaBD.Text, '',
          edCaminhoServidor.Text);
      finally
        FreeAndNil(LConexao);
      end;
      Close;
    end
    else
      MessageDlg('Usuário ou senha incorretos!', mtInformation, [mbOK], 0);
  end;
end;

procedure TfmConexaoBancoDados.btSelecionarClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    edCaminhoServidor.Text := OpenDialog.FileName;
  end;
end;

end.
