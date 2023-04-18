// 내가 한 코드 (한 부분이 안 되서 못풀긴 했지만 방법은 같았음.)
import java.util.*;
class Info{
    String gen;
    int num;
    int time;

    Info(String gen, int num, int time){
        this.gen = gen;
        this.num = num;
        this.time = time;
    }
}
class Solution {
    public int[] solution(String[] genres, int[] plays) {
        Map<String, Integer> map = new HashMap<>(); // 플레이 총 합
        for(int i=0; i<genres.length; i++){
            map.put(genres[i], map.getOrDefault(genres[i], 0) + plays[i]);
        }

        ArrayList<String> res = new ArrayList<>();
        while (!map.isEmpty()) { // map에서 value가 최대인 key를 가져오는 방법.
            int max = 0;
            String max_key = "";
            for (String key : map.keySet()) {
                int value = map.get(key);
                if (value > max) {
                    max = value;
                    max_key = key;
                }
            }

            res.add(max_key);
            map.remove(max_key); //최대인 키 뽑았으면 map에서 제거하여 다시 또 뽑지 않도록 해줌.
        }
//        System.out.println(res);

        ArrayList<Info> result = new ArrayList<>();
        for (String x : res) {
            ArrayList<Info> list = new ArrayList<>();

            for (int i = 0; i < genres.length; i++) {
                if (genres[i].equals(x)) {
                    list.add(new Info(x, i, plays[i]));
                }
            }
            Collections.sort(list, (a, b) -> b.time - a.time);

            //장르에 속한 곡이 하나라면, 하나의 곡만 선택합니다. (이 부분을 못 함.)
            result.add(list.get(0));
            if (list.size() != 1) {
                result.add(list.get(1));
            }
            //result에 먼저 하나를 넣고 만약 list에 같은 장르로 하나 더 남아있으면 하나만 그대로 추가.
        }


        int[] answer = new int[result.size()];
        for (int i = 0; i < result.size(); i++) {
            answer[i] = result.get(i).num;
        }
        return answer;
    }

    public static void main(String[] args) {
        Solution T = new Solution();
        System.out.println(Arrays.toString(T.solution(new String[]{"classic", "pop", "classic", "classic", "pop"},
                new int[]{500, 600, 150, 800, 2500})));
    }
}

/* 출력
[4, 1, 3, 0]
*/


// ---------------------------------------------------------------------------------------------

// 다른 방법 (class 따로 구현하지 않고 Map 안에 Map을 만들어서 적용.)
import java.util.*;
class Solution {
    public int[] solution(String[] genres, int[] plays) {
        ArrayList<Integer> arr = new ArrayList<>();

        HashMap<String, Integer> map = new HashMap<>();
        HashMap<String, HashMap<Integer, Integer>> Info = new HashMap<>();

        for (int i = 0; i < plays.length; i++) {
            if (!map.containsKey(genres[i])) {
                HashMap<Integer, Integer> num = new HashMap<>();
                num.put(i, plays[i]);
                Info.put(genres[i], num);
                map.put(genres[i], plays[i]);
            }
            else{
                Info.get(genres[i]).put(i, plays[i]);
                //이미 있는 key라면 합을 구하기 위해 더해줌.
                map.put(genres[i], map.get(genres[i]) + plays[i]);
            }
        }

        ArrayList<String> list = new ArrayList<>(map.keySet());
        // 이게 합이 최대인 장르를 넣으준 리스트
        Collections.sort(list, (a, b) -> map.get(b) - map.get(a));
//        System.out.println(list);
//        System.out.println(Info);

        for (String key : list) {
            // result에 Info 안의 HashMap의 key와 값을 넣어둠.
            HashMap<Integer, Integer> result = Info.get(key);
            System.out.println(result);
            ArrayList<Integer> genre = new ArrayList<>(result.keySet());

            Collections.sort(genre, (a, b) -> result.get(b) - result.get(a));

            arr.add(genre.get(0));
            if (genre.size() > 1) { // 장르가 2개 이상이면 하나만 더 넣어줌.
                arr.add(genre.get(1));
            }
        }

        int[] answer = new int[arr.size()];
        for (int i = 0; i < arr.size(); i++) {
            answer[i] = arr.get(i);
        }
        return answer;
    }

    public static void main(String[] args) {
        Solution T = new Solution();
        System.out.println(Arrays.toString(T.solution(new String[]{"classic", "pop", "classic", "classic", "pop"},
                new int[]{500, 600, 150, 800, 2500})));
    }
}

