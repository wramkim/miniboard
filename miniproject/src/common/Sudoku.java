package common;

public class Sudoku {
	public static void main(String args[]) {
		int[][] arr = { { 5, 3, 1, 2, 0, 6, 9, 7, 8 }, { 1, 0, 0, 0, 3, 0, 2, 0, 5 }, { 2, 2, 0, 9, 0, 5, 6, 3, 0 },
				{ 3, 5, 3, 0, 8, 0, 0, 0, 9 }, { 0, 1, 0, 6, 0, 3, 7, 0, 0 }, { 4, 0, 0, 0, 5, 0, 0, 0, 0 },
				{ 9, 0, 0, 0, 0, 0, 3, 0, 7 }, { 7, 8, 0, 0, 6, 0, 0, 9, 0 }, { 8, 0, 4, 8, 0, 0, 0, 0, 6 } };

		boolean full = false;

		while (!full) {
			full = false;

			// 유일하게 들어갈 수 있는 값 하나만 탐색

			// 가로줄 탐색
			for (int i = 0; i < 9; i++) {
				int c = 0;
				int[] num = new int[10];

				for (int j = 0; j < 9; j++) {
					num[arr[i][j]]++;
					if (arr[i][j] == 0) {
						c++;
					}
				}

				if (c == 1) {
					for (int n = 1; n <= 9; n++) {
						if (num[n] != 0)
							continue;
						for (int j = 0; j < 9; j++) {
							if (arr[i][j] == 0) {
								arr[i][j] = n;
							}
						}
					}
				}

			}

			// 세로줄 탐색
			for (int i = 0; i < 9; i++) {
				int c = 0;
				int[] num = new int[10];

				for (int j = 0; j < 9; j++) {
					num[arr[j][i]]++;
					if (arr[j][i] == 0) {
						c++;
					}
				}

				if (c == 1) {
					for (int n = 1; n <= 9; n++) {
						if (num[n] != 0)
							continue;
						for (int j = 0; j < 9; j++) {
							if (arr[j][i] == 0) {
								arr[j][i] = n;
							}
						}
					}
				}

			}

			for (int n = 1; n <= 9; n++) {
				for (int i = 0; i < 9; i++) {

				}
			}
			
			// 빈칸 숫자 세기
			for (int i = 0; i < arr.length; i++)
				for (int j = 0; j < arr[i].length; j++)
					if (arr[i][j] == 0)
						full = true;

			break;
		}

		// 출력
		for (int i = 0; i < 9; i++) {
			for (int j = 0; j < 9; j++) {
				System.out.print(arr[i][j] + " ");
			}
			System.out.println();
		}
	}
}
