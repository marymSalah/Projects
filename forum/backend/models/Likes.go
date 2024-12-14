package models

import (
	"database/sql"
	"fmt"
	"net/http"
	"time"
   
)

type Likes struct {
    ID        int       `json:"id"`
    UserID    int       `json:"user_id"`
    PostID    int       `json:"post_id,omitempty"`
    CommentID int       `json:"comment_id,omitempty"`
    CreatedAt time.Time `json:"created_at"`
}

type CommentReaction struct{
    UsercReaction string
    CommentiDD int
}



func Like(w http.ResponseWriter, r *http.Request,db *sql.DB, userID int, title, content string) error {

    if r.Method == http.MethodPost {

		like:= r.FormValue("active-like")
		dislike := r.FormValue("active-dislike")
        fmt.Print(like, dislike)
    
    }

        createdAt := time.Now().Format(time.RFC3339)
    
        stmt, err := db.Prepare("INSERT INTO Posts (user_id, title, content, created_at) VALUES (?, ?, ?, ?)")
        if err != nil {
            return fmt.Errorf("error preparing insert statement: %v", err)
        }
        defer stmt.Close()
    
        _, err = stmt.Exec(userID, title, content, createdAt)
        if err != nil {
            return fmt.Errorf("error executing insert statement: %v", err)
        }
    
        return nil
    }

    func CreateReact( db *sql.DB, user_id int,post_id int,comment_id int, types string ) error {

        createdAt := time.Now().Format(time.RFC3339)
        stmt, err := db.Prepare("INSERT INTO Reactions(user_id,post_id,comment_id,type,created_at) VALUES (?,?,?,?,?)")
        if err != nil {
            return fmt.Errorf("error preparing insert statement: %v", err)
        }
        defer stmt.Close()
    
        _, err = stmt.Exec(user_id,post_id,comment_id,types,createdAt)
        if err != nil {
            return fmt.Errorf("error executing insert statement: %v", err)
        }
    
        return nil
    }

    func CheckRows( db *sql.DB,userId int, post_id int,comment_id int ) (string , error) {

        row, err := db.Query("SELECT * FROM Reactions WHERE user_id=? AND post_id=? AND comment_id=?",userId,post_id,comment_id)
        if err != nil {
            return "error", fmt.Errorf("error executing insert statement: %v", err)
        }
        defer row.Close()
        if row.Next() {
            // There is at least one row
            return "dont", nil
        } else {
            // No rows found
            return "go", nil
        }
    }

    func CheckReact(db *sql.DB, userId int, postId int, commentId int) (string, error) {
        query := "SELECT type FROM Reactions WHERE user_id=? AND post_id=? AND comment_id=?"
        row, err := db.Query(query, userId, postId, commentId)
        if err != nil {
            return "error", fmt.Errorf("error executing query: %v", err)
        }
        defer row.Close()
    
        var reactionType string
        for row.Next() {
            err := row.Scan(&reactionType)
            if err != nil {
                return "error", fmt.Errorf("error scanning row: %v", err)
            }
            if reactionType == "L" {
                return "L", nil
            } else if reactionType == "D" {
                return "D", nil
            }
        }
        return "none", nil
    }

    func RemoveReact( db *sql.DB,userId int, post_id int,comment_id int ) error {
        stmt, err := db.Prepare("DELETE FROM Reactions WHERE user_id=? AND post_id=? AND comment_id=? ")
        if err != nil {
            return fmt.Errorf("error preparing insert statement: %v", err)
        }
        defer stmt.Close()

        _, err = stmt.Exec(userId,post_id,comment_id)
        if err != nil {
            return fmt.Errorf("error executing insert statement: %v", err)
        }

        return nil
    }

    func CountCommentReaction(db *sql.DB, post_id int , commid int, react string) (int, error) {
        query := "SELECT COUNT(*) FROM Reactions WHERE post_id=? AND type=? AND comment_id=?"
        row, err := db.Query(query, post_id,react,commid)
        if err != nil {
            return 0, fmt.Errorf("error executing query: %v", err)
        }
        defer row.Close()

        var count int
        for row.Next() {
            err := row.Scan(&count)
            if err != nil {
                return 0, fmt.Errorf("error scanning row: %v", err)
            }
        }
        return count, nil
    }


    func CommLike(db *sql.DB, userID int,username string ,pid int, comid int , action string) error{
        checkrow, err:= CheckRows(db,userID,pid,comid)
			if err != nil {
					return err
			}
			if action == "addComlike"  {
				if checkrow == "go" {
					action="L" 
					err = CreateReact(db,userID,pid,comid,action)
					if err != nil {
						return err
					}
					}
					if checkrow == "dont"  {
                       ActualReact ,err1 := CheckReact(db, userID, pid,comid)
                       if err1 != nil {
                            return err1
                        }
                        if ActualReact == "L" {
						action="L"
						err = RemoveReact(db,userID,pid,comid)
						if err != nil {
							return err
						}
                    }
                    if ActualReact == "D" {
						action="D"
						err = RemoveReact(db,userID,pid,comid)
						if err != nil {
							return err
						}
                        err = CreateReact(db,userID,pid,comid,"L")
					if err != nil {
						return err
					}
                    }
					}
					}else if action == "addCommDislike"   {
						if checkrow == "go"{
						action="D" 
						err = CreateReact(db,userID,pid,comid,action)
						if err != nil {
							return err
						}
					}
						if checkrow == "dont"{
                            ActualReact ,err1 := CheckReact(db, userID, pid,comid)
                            if err1 != nil {
                                return err1
                            }
                            if ActualReact == "L" {
						action="L"
						err = RemoveReact(db,userID,pid,comid)
						if err != nil {
							return err
						}
                        action="D" 
						err = CreateReact(db,userID,pid,comid,action)
						if err != nil {
							return err
						}
                    }
                    if ActualReact == "D" {
						action="D"
						err = RemoveReact(db,userID,pid,comid)
						if err != nil {
							return err
						}
						
					}
                }
						
						}
                        // else if action == "addComlike" && checkrow == "dont" {
						// action="L"
						// err = RemoveReact(db,userID,pid,comid)
						// if err != nil {
						// 	return err
						// }
						// }else if action == "addCommDislike" && checkrow == "dont" {
						// action="D"
						// err = RemoveReact(db,userID,pid,comid)
						// if err != nil {
						// 	return err
						// }
						// }else if action == "addCommDislike" && checkrow == "dont" {
						// action="L"
						// err = RemoveReact(db,userID,pid,comid)
						// if err != nil {
						// 	return err
						// }
						// action="D"
						// err = CreateReact(db,userID,pid,comid,action)
						// if err != nil {
						// 	return err
						// }
						// }else if action == "addComlike" && checkrow == "dont" {
						// action="D"
						// err = RemoveReact(db,userID,pid,comid)
						// if err != nil {
						// 	return err
						// }
						// action="L"
						// err = CreateReact(db,userID,pid,comid,action)
						// if err != nil {
						// 	return err
						// }
						// }
				
					fmt.Printf(" %v User  clicked %s button for comm %d\n",username , action, comid)
					// Handle the like/dislike action here
					return nil
				        
    }

   
    