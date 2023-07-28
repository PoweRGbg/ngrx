function findDifferences(str1: string, str2: string): string {
    // Helper function to get the LCS between two strings
    function getLCS(a: string, b: string): string {
      const m = a.length;
      const n = b.length;
      const dp: number[][] = Array.from({ length: m + 1 }, () => Array(n + 1).fill(0));
  
      for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
          if (a[i - 1] === b[j - 1]) {
            dp[i][j] = dp[i - 1][j - 1] + 1;
          } else {
            dp[i][j] = Math.max(dp[i - 1][j], dp[i][j - 1]);
          }
        }
      }
  
      let lcs = '';
      let i = m;
      let j = n;
  
      while (i > 0 && j > 0) {
        if (a[i - 1] === b[j - 1]) {
          lcs = a[i - 1] + lcs;
          i--;
          j--;
        } else if (dp[i - 1][j] > dp[i][j - 1]) {
          i--;
        } else {
          j--;
        }
      }
  
      return lcs;
    }
  
    const lcs = getLCS(str1, str2);
    let result = '';
    let i = 0;
    let j = 0;
  
    for (const char of lcs) {
      while (str1[i] !== char) {
        result += `<span class="difference">${str1[i]}</span>`;
        i++;
      }
  
      while (str2[j] !== char) {
        result += `<span class="difference">${str2[j]}</span>`;
        j++;
      }
  
      result += char;
      i++;
      j++;
    }
  
    // Add remaining characters from the input strings
    result += str1.substring(i).replace(/./g, (char) => `<span class="difference">${char}</span>`);
    result += str2.substring(j).replace(/./g, (char) => `<span class="difference">${char}</span>`);
  
    return result;
  }
  