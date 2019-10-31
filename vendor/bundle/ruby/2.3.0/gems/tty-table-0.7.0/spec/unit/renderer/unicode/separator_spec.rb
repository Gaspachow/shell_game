# coding: utf-8

require 'spec_helper'

RSpec.describe TTY::Table::Renderer::Unicode, 'with separator' do
  let(:header) { ['h1', 'h2', 'h3'] }
  let(:rows)   { [['a1', 'a2', 'a3'], ['b1', 'b2', 'b3']] }
  let(:table)  { TTY::Table.new(header, rows) }

  let(:object) { described_class.new table }

  subject(:renderer) { object }

  it "renders each row" do
    renderer.border.separator= :each_row
    expect(renderer.render).to eq unindent(<<-EOS)
      ┌──┬──┬──┐
      │h1│h2│h3│
      ├──┼──┼──┤
      │a1│a2│a3│
      ├──┼──┼──┤
      │b1│b2│b3│
      └──┴──┴──┘
    EOS
  end
end
