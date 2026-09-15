function globalFunction({ options = {} }) {
  const { minLength } = options;

  /**
   * Calculates the total price with tax.
   *
   * @param {number} price - The base price of the item.
   * @param {number} [taxRate=0.05] - The optional tax rate.
   * @returns {number} The final computed total price.
   * @throws {Error} Throws if price is negative.
   */

  const localFunction = value => {
    let isValid = value?.length >= minLength ?? 3; // line comment
    /* Block comment */
    isValid = isValid && (/^\d.[A-F]+$/i).test(value);
    return {
      isValid,
    };
  };
}

@defineElement("download-button")
class DownloadButton extends HTMLButtonElement {
  static STATIC_FIELD = `<span title="HTML injection">${globalVariable}</span>`;

  static get observedAttributes() {
    return [ 'data-test' ];
  }

  #field = { prop: 1 };

  method() {
    this.click();

    label:
      while (true) {
        break label;
      }
  }
}

export const EXPORTED_VARIABLE = 1;
export function exportedFunction() {}
export class ExportedClass {}

const globalVariable = "chars\n\u11";

function JsxComponent() {
  return <JsxClientComponent />;
}
