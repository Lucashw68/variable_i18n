# frozen_string_literal: true

RSpec.describe VariableI18n do
  it "has a version number" do
    expect(VariableI18n::VERSION).not_to be nil
  end

  before do
    I18n.backend.store_translations("en", main_key: "I am a main key")
    I18n.backend.store_translations("en", reused_key: "I am a reused key")
    I18n.backend.store_translations("en", main_key_interp: "main interpolation %<main_var>s")
    I18n.backend.store_translations("en", reused_key_interp: "reused interpolation %<reused_var>s")
    I18n.backend.store_translations("en", main_and_reused_key: "I reuse @[reused_key]")
    I18n.backend.store_translations("en", main_and_reused_interp: 'I reuse @[reused_key_interp, {reused_var: "variable"}]')
  end

  it "simple key word without interpolation" do
    expect(I18n.t("main_key")).to eq("I am a main key")
  end

  it "simple key word with interpolation" do
    expect(I18n.t("main_key_interp", main_var: "variable")).to eq("main interpolation variable")
  end

  it "reusing a key word without interpolation" do
    expect(I18n.t("main_and_reused_key")).to eq("I reuse I am a reused key")
  end

  it "reusing a key word with interpolation" do
    expect(I18n.t("main_and_reused_interp")).to eq("I reuse reused interpolation variable")
  end
end
