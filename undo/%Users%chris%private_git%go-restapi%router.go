Vim�UnDo� ��0�]
*�P��u+2�n��m����                                      U�s    _�                              ����                                                                                                                                                                                                                                                                                                                                                             U�r     �                }�                	return router�                 �                	}�                 �                			Handler(handler)�                			Name(route.Name).�                			Path(route.Pattern).�                			Methods(route.Method).�                			router.�                 �                '		handler = Logger(handler, route.Name)�                		handler = route.HandlerFunc�                 �                		var handler http.Handler�   
             	for _, route := range routes {�   	             ,	router := mux.NewRouter().StrictSlash(true)�      
           �      	          func NewRouter() *mux.Router {�                 �                )�                	"github.com/gorilla/mux"�                	"net/http"�                import (�                 �                 package main�                 5��